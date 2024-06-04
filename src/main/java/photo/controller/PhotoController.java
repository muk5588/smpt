package photo.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import board.dto.Board;
import board.dto.BoardFile;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import board.service.BoardService;
import board.service.FileService;
import comment.dto.Comment;
import photo.dto.Photo;
import photo.dto.PhotoFile;
import photo.service.face.PhotoFileService;
import photo.service.face.PhotoService;
import report.dto.CommReport;
import report.service.ReportService;
import user.dto.User;
import util.Paging;
import vo.GoodVO;

@Controller
@RequestMapping("/photo")
public class PhotoController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired private PhotoService photoService;
	@Autowired private PhotoFileService photofileService;
	@Autowired private ServletContext servletContext;
	@Autowired private BoardService boardService;
	@Autowired private ReportService reportService;
	@Autowired private FileService fileService;


	
	@GetMapping("/list")
	public String list(Model model,
			@RequestParam(defaultValue = "0")int curPage,
			@RequestParam(value = "categoryNo", required = false) Integer categoryNo,
			@RequestParam(value = "search", required = false)String search,
			@RequestParam(value="searchKind", required = false) String searchKind) {
		
		logger.info("/photo/list [GET]");
		logger.info("/photo/list search : {}", search);
	    logger.info("/photo/list searchKind : {}", searchKind);
	    logger.info("/photo/list categoryNo : {}", categoryNo);
		String URL = "/photo/list";
		
		 Paging paging = new Paging();
		    paging.setSearch(search);
		    paging.setSearchKind(searchKind);
		    
		    if (categoryNo != null) {
		        paging.setCategoryNo(categoryNo);
		    }
		    
		    if (null !=  search && !"".equals(search)) {
		        paging = photoService.getPaging(curPage, paging);
		    } 
		    else {
		        paging = photoService.getPaging(curPage, paging);
		    }
		    logger.info("$$$%%%paging : {}",paging);
		    
		    //게시글 0개 조회 되면
		    if( paging == null) {
		    	paging = new Paging();
		    	paging.setSearch(search);
		    	paging.setSearchKind(searchKind);
		    	if (categoryNo != null) {
		    		paging.setCategoryNo(categoryNo);
		    	}
		    	model.addAttribute("curPage", curPage);
		    	model.addAttribute("paging", paging);
		    	return URL;
		    	
		    }
		    paging.setSearch(search);
		    paging.setSearchKind(searchKind);
		    
		    List<Photo> list = null;
		    List<Map<String, Object>> recommList = null;
			String name = null;
		    logger.info("paging : {}",paging);
		    
		    if (categoryNo != null) {
		    	paging.setCategoryNo(categoryNo);
		        list = photoService.listByCategory(paging);
		        recommList = photoService.getuserRecommendRes(list);
				name = photoService.getCategoryName(categoryNo);
		    } else {
		        list = photoService.list(paging);
		        recommList = photoService.getuserRecommendRes(list);
				name = "전체";
		    }

		    
		    for (Photo photo : list) {
		        List<PhotoFile> files = photofileService.getFileList(photo.getBoardNo());
		        photo.setFiles(files);  // Photo 객체에 파일 목록 설정
		    }
//		    logger.debug("list : {}", list);
//		    logger.debug("recommList : {}", recommList);
		    for(Photo M : list) {
//				logger.debug("!!@!@!@M : {}", M); 
		    }
		    for(Map<String, Object> M : recommList) {
//		        logger.debug("M : {}", M.toString());
		    }
		    model.addAttribute("URL", URL);
		    model.addAttribute("totalrecomm", recommList);
		    model.addAttribute("curPage", curPage);
		    model.addAttribute("paging", paging);
		    model.addAttribute("list", list);
			model.addAttribute("name", name);
		
		return URL;
		
	}
	
	@GetMapping("/category")
	public void category(Model model) {
		
	}
	
	@GetMapping("/view")
	public void view(
			@RequestParam("boardNo") int boardno
			, Photo photo
			, Board board
			, Model model
			, HttpSession session
			, @RequestParam(value = "curpage", defaultValue = "0") int curPage
			, @RequestParam(value = "categoryNo", required = false, defaultValue = "0") int categoryNo
			, @RequestParam(value = "userno", required = false, defaultValue = "0") int userno
			) {
		
		photo = photoService.viewByBoardNo(boardno);
		User user = (User)session.getAttribute("dto1");
		int recomm = 0;
		if( null == user ) {
			recomm = photoService.viewRecommend(boardno);
		}else {
			Good paramGood = new Good(user.getUserno(), boardno);
			GoodVO good = photoService.getRecommendVO(paramGood);
			model.addAttribute("isRecomm", good.getIsRecomm());
			logger.info("isRecomm : {}", good.getIsRecomm());
			recomm = good.getTotalRecomm();
		}
		List<Comment> comment = boardService.commentList(board);
		
		List<CommReport> reportlist = reportService.reportcommlist();
		Iterator<Comment> iterator = comment.iterator();
		while (iterator.hasNext()) {
			Comment comment2 = iterator.next();
			for (CommReport report : reportlist) {
				if (report.getCommNo() == comment2.getCommNo()) {
					iterator.remove();
					break;
				}
			}
		}
		
		model.addAttribute("comment", comment);
		model.addAttribute("recomm", recomm);
		logger.info("recomm : {}", recomm);
		model.addAttribute("curPage", curPage);
		model.addAttribute("photo", photo);
		model.addAttribute("userno",userno);
	}
	
	
	
	@GetMapping("/write")
	public void write(Model model, HttpSession session) {
		List<Category> categorylist = photoService.categoryList();
		model.addAttribute("categorylist",categorylist);
	}
	
	@PostMapping("/write")
	public String writeProc(
			HttpSession session
			, Photo photo
			, Board board
			, @RequestParam("categoryNo") int categoryNo
			, @RequestAttribute(required = false)MultipartFile file
			) {
		logger.debug("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		User user = (User) session.getAttribute("dto1");
		logger.info("photo : {}", photo);
		logger.info("categoryNo : {}", categoryNo);
		String categoryTitle =  "[";
		categoryTitle += photoService.getCategoryName(categoryNo);
		categoryTitle += "]";
		categoryTitle += photo.getTitle();
		photo.setTitle(categoryTitle);
		photo.setCategoryNo(categoryNo);
		photo.setUserNo(user.getUserno());
		photo.setNickName(user.getNickname());
		int res = photoService.write(photo);

		String content = photo.getContent();
		logger.info("content Ȯ�� : {}", content);
		List<String> originNames = photofileService.extractOriginName(content);
		logger.info("originNames Ȯ�� : {}", originNames);
		List<String> storedNames = photofileService.extractStoredName(content, originNames);
		logger.info("storedNames Ȯ�� : {}", storedNames);
		if (originNames != null && storedNames != null && originNames.size() == storedNames.size() && !originNames.isEmpty() && !storedNames.isEmpty()) {
			ArrayList<PhotoFile> files = new ArrayList<>();
			logger.info("�̹��� ���� ó���� :%%%%%%%%%%%%%%%%%%%%%%%%%%" );
		    for (int i = 0; i < originNames.size(); i++) {
		        String originName = originNames.get(i);
		        String storedName = storedNames.get(i);
		        if (originName != null && storedName != null) {
		            PhotoFile bf = new PhotoFile();
		            bf.setBoardNo(photo.getBoardNo());
		            bf.setOriginName(originName);
		            bf.setStoredName(storedName);
		            files.add(bf);
		        }
		    }
		    photofileService.setFile(files);
		}
        
		logger.info("photo �� Ȯ�� : {}", photo);
		
		if( null == file ) {
			logger.debug("÷�� ���� ����");
		}else if( file.getSize() <= 0 ){
			logger.debug("������ ũ�Ⱑ 0");
		}else { 
//			for( )
			photofileService.filesave(photo,file);
		}
		if (res > 0 && file != null && !file.isEmpty()) {
	        // 이미지를 한 번만 저장하도록 수정
	        photofileService.filesave(photo, file);
	    }
		
		
		return "redirect:/photo/list?categoryNo=" + categoryNo;
	}
	@ResponseBody
	@PostMapping("/fileupload")
	public void fileupload(HttpServletResponse response
			, HttpServletRequest request
//			, MultipartFile file
//			, MultipartHttpServletRequest multiRequest 
//			, Board board
			) {
		logger.debug("/fileupload&&&&&&&&&&&&&&&&&&&&&&&&");
//		logger.debug("file : {}", file);
		BoardFile file =fileService.fileTempSave(request,response); 
		logger.debug("!@$#!@#!@#!@#!@#!files : {}", file);
		
	}
	
	@ResponseBody
	@RequestMapping("/fileChk")
	public List<PhotoFile> fileChk(@RequestParam("boardno")int boardNo) {
		List<PhotoFile> files = photofileService.getFileList(boardNo);
		logger.info("fileChk : {}", files);
		return files;
	}
	
	@GetMapping("/update")
	public void update(
			int boardNo
			, Model model
			) {
		logger.info("{}",boardNo);
		List<Category> categorylist = photoService.categoryList();
		Photo photo = photoService.boardView(boardNo);
		model.addAttribute("categorylist", categorylist);
		model.addAttribute("photo", photo);
	}
	 
	 @PostMapping("/update")
		public String updateProc(
				Photo photo
				,  @RequestParam(value = "file", required = false) MultipartFile file
				) {
			logger.info("{}", photo);
			photo.setUpdateDate(new Date());
			int res = photoService.boardUpdate(photo);
			
			 if (file != null && !file.isEmpty()) {
			        photofileService.filesave(photo, file);
			    }
			
			if ( res > 0) {
				return "redirect:/photo/list?categoryNo=" + photo.getCategoryNo();
			}
			return "./list";
		}
	 
	 @RequestMapping("/delete")
		public String delete(@RequestParam("boardNo") int boardno) {
			logger.debug("delete ���� : {}",boardno);
			
			Photo deleteBoard = new Photo();
			Comment comment	= new Comment();
			deleteBoard.setBoardNo(boardno);
			comment.setBoardNo(boardno);
			photoService.commentDeleteAll(comment);
			photoService.boardDelete(deleteBoard);
			
			return "redirect:./list";
		}
		
	 @RequestMapping("/recommend")
		public @ResponseBody RecommendRes recommend(
				Photo recommendBoard
				, HttpSession session
				) {
			logger.info("��õ Ȯ�� {}, {} ", recommendBoard, session.getAttribute("isLogin"));
			
			photoService.recommend(recommendBoard);

			RecommendRes res = photoService.getRecommendRes(recommendBoard);
			return res;
		}
	 
	 @ResponseBody
		@RequestMapping("/listDelete")
		public int listDelete(
//			public void listDelete( 
				@RequestParam("boardNo[]") int[] no) {
			ArrayList<Integer> boardno = new ArrayList<Integer>();
			for(int i = 0; i < no.length; i++) {
//				boardService.listDelete(boardno[i]);
				boardno.add(no[i]);
			}
			photoService.deleteComment(boardno);
			photoService.deleteGood(boardno);
			photofileService.listDeleteByBoardNo(boardno);
			int res = photoService.listDeleteByBoardNo(boardno);
			logger.debug("���� �Ϸ�");
			return res;
		}
	
	 @ResponseBody
	 @RequestMapping("/boardFileChk")
	 private void boardImageChk(int boardno) {
		logger.debug("���� üũ ");
		logger.debug("boardno : {}", boardno);
	 }
	 
	 @RequestMapping("/userbyboardlist")
	 public String userByBoardList(
			 Model model, HttpSession session
			 , @RequestParam(defaultValue = "0") int curPage
			 , @RequestParam(value = "search", required = false) String search
			 , @RequestParam(value = "searchKind", required = false) String searchkind
			 ) {
		 
		 String URL = "/photo/userbyboardlist";
		 model.addAttribute("URL", URL);
		 logger.debug("userbyboardlist");
		 logger.debug("userbyboardlist");
		 User login = (User) session.getAttribute("dto1");
		 if( login == null ) {
			 return "redirect:/login";
		 }
		 Paging paging = new Paging();
		 paging.setSearch(search);
		 paging.setSearchKind(searchkind);
		 if(null != search && !"".equals(search)) {
			 paging = photoService.getPagingByUserNo(curPage,paging,login);
		 }else {
			 paging = photoService.getPagingByUserNo(curPage,paging,login);
		 }
		 
		//페이징 결과 없을 경우 (cnt 0개 )
			if( paging == null ) {
				paging = new Paging();
				paging.setSearch(search);
				paging.setSearchKind(searchkind);
				model.addAttribute("curPage", curPage);
				model.addAttribute("paging", paging);
				model.addAttribute("param", login);
				return "photo/userbyboardlist";
			}
			paging.setSearch(search);
			paging.setSearchKind(searchkind);
			paging.setUserno(login.getUserno());
			logger.info("{}", paging);
			List<Photo> list = photoService.userByBoardList(paging);
			logger.debug("list : {}", list);
			//조회 결과 없을 경우
			if( list == null ) {
				model.addAttribute("curPage", curPage);
				model.addAttribute("paging", paging);
				model.addAttribute("param", login);
				logger.debug("paramparamparamparam: {}", login);
				return "photo/userbyboardlist";
			}

			List<Map<String, Object>> recommList = null;
			recommList = photoService.getuserRecommendRes(list);
			logger.debug("recommList : {}", recommList);
			for(Map<String, Object> M : recommList) {
				logger.debug("M : {}", M.toString());
			}
			logger.debug("paramparamparamparam: {}", login);

			model.addAttribute("totalrecomm", recommList);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("list", list);
		 
		 return "photo/userbyboardlist";
	 }
	 
	 @RequestMapping("/userbyrecommlist")
	 public String userbyRecommList(
			 @SessionAttribute(value = "dto1", required = false)User login
			 , @RequestParam(defaultValue = "0")int curPage, Model model
			 , @RequestParam(value = "search", required = false)String search
			 , @RequestParam(value = "searchKind", required = false)String searckind) {
		 
		 String URL = "/photo/userbyrecommlist";
		 model.addAttribute("URL",URL);
		 Paging paging = new Paging();
		 paging.setSearch(search);
		 paging.setSearchKind(searckind);
		 if(null != search && !"".equals(search)) {
			 paging = photoService.getPagingByUserNoGood(curPage,paging,login);
		 }else {
			 paging = photoService.getPagingByUserNoGood(curPage,paging,login);
		 }
		 
		 if( paging == null ) {
			 paging = new Paging();
			 paging.setSearch(search);
			 paging.setSearchKind(searckind);
			 paging.setUserno(login.getUserno());
		 }
		 paging.setSearch(search);
		 paging.setSearchKind(searckind);
		 paging.setUserno(login.getUserno());
		 List<Photo> list2 = photoService.userbyrecommList(paging);
		 if( list2 == null ) {
			 model.addAttribute("curPage", curPage);
			 model.addAttribute("paging", paging);
			 model.addAttribute("param", login);
			 logger.debug("paramparamparamparm: {}", login);
			 return "photo/userbyboardlist";
		 }
		 
		 return "phot/userbyrecommlist";
	 }
	 
	 @RequestMapping("/fileDown")
	 public String fileDown(int fileNo, Model model) {
		 BoardFile file = fileService.getFileByFileNo(fileNo);
		 logger.info("���� �ٿ�ε� : {}", file);
			
		model.addAttribute("downFile", file);
			
		logger.info("���� �ٿ�ε� : {}", file);
		return "downView";	
		}
	 
	 
    
}