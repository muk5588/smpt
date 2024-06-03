package Story.service;


import comment.dao.CommentDao;
import comment.dto.Comment;
import Story.dao.StoryDao;
import Story.dto.Story;
import user.dto.User;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import board.dao.FileDao;
import board.dto.Board;
import board.dto.BoardFile;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import util.Paging;
import vo.GoodVO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class StoryServiceImpl implements StoryService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired private StoryDao storyDao;
	@Autowired private CommentDao commentDao;
	@Autowired private HttpSession session;
	@Autowired private SqlSession sqlSession;
	@Autowired
    private ServletContext servletContext;

    @Autowired
    private FileDao fileDao;
	
	@Override
	public List<Story> list(Paging paging) {
		return storyDao.selectAll(paging);
	}
	
	@Override
	public Paging getPaging(int curPage, Paging paging) {
		
		int totalCount = storyDao.selectCntAll(paging);
		logger.info("totalCount : {}",totalCount);
		if( totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		
		return pagingres;
	}
	
	@Override
	public Story viewByBoardNo(int boardno) {
		storyDao.hit(boardno);
		return storyDao.select(boardno);
	}

	@Override
	public int write(Story story) {
		return storyDao.write(story);
	}

	@Override
	public Story StoryView(int boardNo) {
		return storyDao.selectStoryByBoardNo(boardNo);
	}


	@Override
	public int StoryUpdate(Story story) {
		return storyDao.updateStory(story);
	}

	@Override
	public void StoryDelete(Story deleteStory) {
		storyDao.deleteStory(deleteStory);
	}

	@Override
	public void recommend(Story recommendStory) {
		
		int userno = (int)session.getAttribute("isLogin");
		int no = recommendStory.getBoardNo();
		Good good = new Good(userno, no);
		
		if( storyDao.isRecomm(good) > 0 ) {
			storyDao.deleteRecommend(good);
			
		}else {
			storyDao.insertRecommend(good);
			
		}

	}

	@Override
	public boolean isRecommend(HttpSession session, int boardno) {
		int res=0;
		if( null != session.getAttribute("userno")) {
			Good good = new Good((int)this.session.getAttribute("userno"), boardno);
			res = storyDao.isRecomm(good);
		}
		
		if( res > 0 ) {
			return true;
		}
		return false;
	}

	@Override
	public RecommendRes getRecommendRes(Story recommendStory) {
		if( null != session.getAttribute("isLogin")) {
			Good good = new Good((int)this.session.getAttribute("isLogin"), recommendStory.getBoardNo());
			return storyDao.getRecommendRes(good);
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> getRecommendRes(Paging paging) {
		return storyDao.selectAllRecomm(paging);
	}

	@Override
	public int viewRecommend(int boardno) {
		return storyDao.getRecommend(boardno);
	}

	@Override
	public List<Comment> commentList(Board board) {
		return commentDao.selectCommentByBoardNo(board);
	}

	@Override
	public int commentInsert(Comment comment) {
		return commentDao.commentInsert(comment);
	}

	@Override
	public void commentDelete(Comment comment) {
		commentDao.deleteComment(comment);
	}

	@Override
	public int listDeleteByBoardNo(ArrayList<Integer> boardno) {
		return storyDao.listDeleteByBoardNo(boardno);
	}

	@Override
	public List<Category> categoryList() {
		return storyDao.categoryList();
	}

	@Override
	public List<Story> StoryList(int userno) {
		return storyDao.StoryList(userno);
	}
/**
 * 보드 삭제시 그 보드에 연관된 댓글과 파일삭제*/
	@Override
	public void commentDeleteAll(Comment comment) {
		commentDao.deleteCommentAll(comment);
	}

	@Override
	public Comment commentByBoardNo(int commno) {
		return commentDao.commentByBoardNo(commno);
	}

	@Override
	public Paging getLogPaging(int curPage, Paging paging) {

		int totalCount = storyDao.selectLogCntAll(paging);

		Paging pagingres = new Paging(totalCount, curPage);

		return pagingres;
	}

	@Override
	public Paging getAdminPaging(int curPage, Paging paging) {
		int totalCount = storyDao.selectAdminCntAll(paging);

		Paging pagingres = new Paging(totalCount, curPage);

		return pagingres;
	}

	@Override
	public List<Story> userByStoryList(Paging paging) {
		return storyDao.userByStoryList(paging);
	}

	@Override
	public List<Story> userrecommList(int userno) {
		return storyDao.userrecommList(userno);
	}

	@Override
	public void deleteComment(ArrayList<Integer> boardno) {
		storyDao.deleteComment(boardno);
	}

	@Override
	public void deleteGood(ArrayList<Integer> boardno) {
		storyDao.deleteGood(boardno);
	}

	@Override
	public GoodVO getRecommendVO(Good paramGood) {
		return storyDao.getRecommendVO(paramGood);
	}

	@Override
	public List<Story> listByCategory(Paging paging) {
		 return storyDao.listByCategory(paging);	

	}

	@Override
	public List<Map<String, Object>> getuserRecommendRes(List<Story> list) {
		return storyDao.getuserRecommendRes(list);
	}

	@Override
	public String getCategoryName(int categoryNo) {
		String cName = "";
		String str = storyDao.getCategoryName(categoryNo);
		
        if (str.contains(" - ")) {
            String[] parts = str.split(" - ");
            cName = parts[1];
        } else {
        	cName = str;
        }
		
		return cName;
	}

	@Override
	public List<Story> list() {
		return storyDao.list();
	}

	@Override
	public List<Story> userbyrecommList(Paging paging) {
		return storyDao.userbyrecommList(paging);
	}

	@Override
	public Paging getPagingByUserNo(int curPage, Paging paging, User login) {
		
		int totalCount = storyDao.selectCntByUserNo(paging,login);
		logger.info("totalCount : {}",totalCount);
		if(totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		
		return pagingres;
	}

	
	@Override
	public List<BoardFile> getFilesByBoardNo(int boardNo) {
	    return storyDao.getFilesByBoardNo(boardNo);
	}
	
	
	@Override
    public void filesave(Board board, MultipartFile file) {
        String storedPath = servletContext.getRealPath("/resources/boardUpload");
        File storedFolder = new File(storedPath);
        if (!storedFolder.exists()) {
            storedFolder.mkdir();
        }

        String storedName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        File dest = new File(storedFolder, storedName);
        try {
            file.transferTo(dest);
            BoardFile boardFile = new BoardFile();
            boardFile.setBoardNo(board.getBoardNo());
            boardFile.setOriginName(file.getOriginalFilename());
            boardFile.setStoredName(storedName);
            fileDao.insert(boardFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



}
