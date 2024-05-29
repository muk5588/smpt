 package Story.controller;

 
import board.dto.Board;
import board.dto.BoardFile;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import board.service.BoardService;
 import board.service.FileService;
 import comment.dto.Comment;
import Story.dto.Story;
import Story.service.StoryService;

import org.slf4j.Logger;
 import org.slf4j.LoggerFactory;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.stereotype.Controller;
 import org.springframework.ui.Model;
 import org.springframework.web.bind.annotation.*;
 import org.springframework.web.multipart.MultipartFile;
 import user.dto.User;
 import util.Paging;
 import vo.GoodVO;

 import javax.servlet.ServletContext;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 import java.util.ArrayList;
 import java.util.List;
 import java.util.Map;

@Controller
@RequestMapping("/recomm")
public class RecommController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired private BoardService boardService;
	@Autowired private StoryService storyService;
	@Autowired private FileService fileService;
	@Autowired private ServletContext servletContext;
	
	@GetMapping("/recommlist")
	public String list(
	    Model model,
	    @RequestParam(defaultValue ="0") int curPage,
	    @RequestParam(value="search",required = false) String search,
	    @RequestParam(value="searchKind", required = false) String searchKind,
	    @RequestParam(value="categoryNo", required = false) Integer categoryNo) {

	    logger.info("/Recomm/recommlist [GET]");
	    logger.info("/Recomm/recommlist search : {}", search);
	    logger.info("/Recomm/recommlist searchKind : {}", searchKind);
	    logger.info("/Recomm/recommlist categoryNo : {}", categoryNo);
		String URL = "/recomm/recommlist";
	    // 페이징 계산
	    Paging paging = new Paging();
	    paging.setSearch(search);
	    paging.setSearchKind(searchKind);
	    
	    if (categoryNo != null) {
	        paging.setCategoryNo(categoryNo);
	    }
	    
	    if (null !=  search && !"".equals(search)) {
	        paging = storyService.getPaging(curPage, paging);
	    } 
	    else {
	        paging = storyService.getPaging(curPage, paging);
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
	    
	    List<Story> list = null;
	    List<Map<String, Object>> recommList = null;
		String name = null;
	    logger.info("paging : {}",paging);
	    
	    if (categoryNo != null) {
	    	paging.setCategoryNo(categoryNo);
	        list = storyService.listByCategory(paging);
	        recommList = storyService.getuserRecommendRes(list);
			name = storyService.getCategoryName(categoryNo);
	    } else {
	        list = storyService.list(paging);
	        recommList = storyService.getuserRecommendRes(list);
			name = "전체";
	    }

//	    logger.debug("list : {}", list);
//	    logger.debug("recommList : {}", recommList);
	    // 각 스토리에 이미지 출력: 파일 리스트를 추가
	    for (Story story : list) {
	        List<BoardFile> files = fileService.getFilesByBoardNo(story.getBoardNo());
	        story.setFiles(files);
	    }

	    for(Map<String, Object> M : recommList) {
//	        logger.debug("M : {}", M.toString());
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
	public void category(Model model){
	}
	
	@GetMapping("/view")
	public void view(
			@RequestParam("boardNo") int boardno
			, Board board
			, Story story
			, Model model
			, HttpSession session
			, @RequestParam(value="curPage", defaultValue="0") int curPage
			, @RequestParam(value ="categoryNo", required = false, defaultValue = "0")int categoryNo 
			, @RequestParam(value ="usrno", required = false, defaultValue = "0")int usrno
			) {

		story =  storyService.viewByBoardNo(boardno);
		User user = (User)session.getAttribute("dto1");
		int recomm = 0;
		if( null == user) {
			recomm = storyService.viewRecommend(boardno);
		}else {
			Good paramGood = new Good(user.getUserno(), boardno);
			GoodVO good = storyService.getRecommendVO(paramGood);
			model.addAttribute("isRecomm", good.getIsRecomm());
			logger.info("isRecomm : {}", good.getIsRecomm());
			recomm = good.getTotalRecomm();
		}
		List<BoardFile> files = fileService.getFilesByBoardNo(boardno); // 파일 리스트 조회 추가 : 이미지 출력
		model.addAttribute("files", files); // 모델에 파일 리스트 추가 : 이미지 출력
		
		List<Comment> comment = storyService.commentList(board);
		model.addAttribute("comment", comment);
		model.addAttribute("recomm", recomm);
		logger.info("recomm : {}", recomm);
		model.addAttribute("curPage", curPage);
		model.addAttribute("story", story);
		model.addAttribute("usrno",usrno);
	}
	
	@GetMapping("/write")
	public void write(Model model, HttpSession session) {
		List<Category> categorylist = storyService.categoryList();
		model.addAttribute("categorylist", categorylist);
	}
	
	@PostMapping("/write")
	public String writeProc(
			HttpSession session
			, Board board
			, @RequestParam("categoryNo") int categoryNo
			, @RequestParam("files") List<MultipartFile> files	//다중 이미지 첨부 
			) {
		logger.debug("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		User user = (User) session.getAttribute("dto1");
		logger.info("board : {}", board);
		logger.info("categoryNo : {}", categoryNo);
		String categoryTitle =  "[";
		categoryTitle += boardService.getCategoryName(categoryNo);
		categoryTitle += "]";
		categoryTitle += board.getTitle();
		board.setTitle(categoryTitle);
		board.setCategoryNo(categoryNo);
		board.setUserNo(user.getUserno());
		board.setNickName(user.getNickname());
		int res = boardService.write(board);

		String content = board.getContent();
		logger.info("content Ȯ�� : {}", content);
		List<String> originNames = fileService.extractOriginName(content);
		logger.info("originNames Ȯ�� : {}", originNames);
		List<String> storedNames = fileService.extractStoredName(content, originNames);
		logger.info("storedNames Ȯ�� : {}", storedNames);
		
		if (originNames != null && storedNames != null && originNames.size() == storedNames.size() && !originNames.isEmpty() && !storedNames.isEmpty()) {
			ArrayList<BoardFile> filesList = new ArrayList<>();
			logger.info("�̹��� ���� ó���� :%%%%%%%%%%%%%%%%%%%%%%%%%%" );
		    for (int i = 0; i < originNames.size(); i++) {
		        String originName = originNames.get(i);
		        String storedName = storedNames.get(i);
		        if (originName != null && storedName != null) {
		            BoardFile bf = new BoardFile();
		            bf.setBoardNo(board.getBoardNo());
		            bf.setOriginName(originName);
		            bf.setStoredName(storedName);
		            filesList.add(bf);
		        }
		    }
		    fileService.setFile(filesList);
		}
        
		logger.info("board �� Ȯ�� : {}", board);
		
		
		// 다중 이미지 출력
		 for (MultipartFile file : files) {
		 if (file != null && !file.isEmpty()) { 
			 fileService.filesave(board, file);  //이미지 출력
		 
		 }
		}
		
		
		 return "redirect:/recomm/recommlist?categoryNo=" + categoryNo; // 글작성 시 선택한 카테고리 목록으로 이동.
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
	public List<BoardFile> fileChk(@RequestParam("boardno")int boardNo) {
		List<BoardFile> files = fileService.getFileList(boardNo);
		logger.info("fileChk : {}", files);
		return files;
	}
	
	 @GetMapping("/update")
	    public void update(
	            @RequestParam("boardNo") int boardNo
	            , Model model
	            ) {
	        logger.info("게시물 번호: {}",boardNo);
	        Board board = boardService.boardView(boardNo);
	        model.addAttribute("board", board);
	    }

	    @PostMapping("/update")
	    public String updateProc(
	            Board board,
	            @RequestParam("file") MultipartFile file,
	            HttpSession session) {
	        logger.info("게시물 업데이트: {}", board);

	        int res = boardService.boardUpdate(board);

	        if (res > 0) {
	            if (file != null && !file.isEmpty()) {
	                fileService.filesave(board, file);
	            }
	            return "redirect:/recomm/view?boardNo=" + board.getBoardNo(); // 해당 글 상세페이지로 이동
	        }
	        return "redirect:/recomm/view?boardNo=" + board.getBoardNo(); // 해당 글 상세페이지로 이동
	    }
	
	@RequestMapping("/delete")
	public String delete(@RequestParam("boardNo") int boardno) {
		logger.debug("delete ���� : {}",boardno);
		
		Board deleteBoard = new Board();
		Comment comment	= new Comment();
		deleteBoard.setBoardNo(boardno);
		comment.setBoardNo(boardno);
		boardService.commentDeleteAll(comment);
		boardService.boardDelete(deleteBoard);
		
		return "redirect:./recommlist";
	}
	
	@RequestMapping("/recommend")
	public @ResponseBody RecommendRes recommend(
			Board recommendBoard
			, HttpSession session
			) {
		logger.info("��õ Ȯ�� {}, {} ", recommendBoard, session.getAttribute("isLogin"));
		
		boardService.recommend(recommendBoard);

		RecommendRes res = boardService.getRecommendRes(recommendBoard);
		return res;
	}
	
	@ResponseBody
	@RequestMapping("/listDelete")
	public int listDelete(
//		public void listDelete( 
			@RequestParam("boardNo[]") int[] no) {
		ArrayList<Integer> boardno = new ArrayList<Integer>();
		for(int i = 0; i < no.length; i++) {
//			boardService.listDelete(boardno[i]);
			boardno.add(no[i]);
		}
		boardService.deleteComment(boardno);
		boardService.deleteGood(boardno);
		fileService.listDeleteByBoardNo(boardno);
		int res = boardService.listDeleteByBoardNo(boardno);
		logger.debug("���� �Ϸ�");
		return res;
	}
	
	@ResponseBody
	@RequestMapping("/boardFileChk")
	private void boardImageChk(int boardno) {
		logger.debug("���� üũ ");
		logger.debug("boardno : {}", boardno);
//		int res = fileService.getFileCnt(boardno);
//		if(res <= 0) {
////			return null;
//		}else if(res == 1) {
//			BoardFile file = fileService.getFileByBoardNo(boardno);
//		}else if(res > 1) {
////			List<BoardFile> file = fileService.getFileByBoardNo(boardno);
//		}
		
	}
	@RequestMapping("/userbyboardlist")
	public String userByBoardList(
			Model model,HttpSession session,
			@RequestParam(defaultValue ="0") int curPage
			,@RequestParam(value="search",required = false) String search,
			@RequestParam(value="searchKind", required = false) String searchKind
			) {
		// ����¡ ���
		String URL = "/board/userbyboardlist";
		model.addAttribute("URL", URL);
		logger.debug("userbyboardlist ");
		logger.debug("userbyboardlist ");
		User login = (User) session.getAttribute("dto1");
		if( login == null) {
			return "redirect:/login";
		}
		Paging paging = new Paging();
		paging.setSearch(search);
		paging.setSearchKind(searchKind);
		if(null !=  search && !"".equals(search)) {
			paging = boardService.getPagingByUserNo(curPage,paging,login);
		}else {
			paging = boardService.getPagingByUserNo(curPage,paging,login);
		}
		//페이징 결과 없을 경우 (cnt 0개 )
		if( paging == null ) {
			paging = new Paging();
			paging.setSearch(search);
			paging.setSearchKind(searchKind);
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("param", login);
			return "board/userbyboardlist";
		}
		paging.setSearch(search);
		paging.setSearchKind(searchKind);
		paging.setUserno(login.getUserno());
		logger.info("{}", paging);
		List<Board> list = boardService.userByBoardList(paging);
		logger.debug("list : {}", list);
		//조회 결과 없을 경우
		if( list == null ) {
			model.addAttribute("curPage", curPage);
			model.addAttribute("paging", paging);
			model.addAttribute("param", login);
			logger.debug("paramparamparamparam: {}", login);
			return "board/userbyboardlist";
		}

		List<Map<String, Object>> recommList = null;
		recommList = boardService.getuserRecommendRes(list);
		logger.debug("recommList : {}", recommList);
		for(Map<String, Object> M : recommList) {
			logger.debug("M : {}", M.toString());
		}
		logger.debug("paramparamparamparam: {}", login);

		model.addAttribute("totalrecomm", recommList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);

		return "board/userbyboardlist";
	}

	@RequestMapping("/userbyrecommlist")
	public void userbyRecommList(@SessionAttribute(value = "dto1", required = false) User login,
								 @RequestParam(defaultValue ="0") int curPage, Model model
								,@RequestParam(value="search",required = false) String search
								,@RequestParam(value="searchKind", required = false ) String searchKind){

		String URL = "/board/userbyrecommlist";
		model.addAttribute("URL", URL);
		Paging paging = new Paging();
		paging.setSearch(search);
		paging.setSearchKind(searchKind);
		if(null !=  search && !"".equals(search)) {
			paging = boardService.getPagingByUserNo(curPage,paging,login);
		}else {
			paging = boardService.getPagingByUserNo(curPage,paging,login);
		}
		//게시글 없는 경우
		if( paging == null ) {
			paging.setSearch(search);
			paging.setSearchKind(searchKind);
			paging.setUserno(login.getUserno());
		}
		paging.setSearch(search);
		paging.setSearchKind(searchKind);
		paging.setUserno(login.getUserno());
		List<Board> list2 = boardService.userbyrecommList(paging);

		model.addAttribute("list2", list2);
		model.addAttribute("paging", paging);
	}
	
	@RequestMapping("/fileDown")
	public String fileDown(int fileNo, Model model) {
		BoardFile file = fileService.getFileByFileNo(fileNo);
		logger.info("���� �ٿ�ε� : {}", file);
		
		model.addAttribute("downFile", file);
		
		logger.info("���� �ٿ�ε� : {}", file);
		return "downView";
	}
	
	//한국어 테스트
	
	
}
