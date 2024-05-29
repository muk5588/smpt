package photo.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.Board;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import comment.dao.CommentDao;
import comment.dto.Comment;
import photo.dao.PhotoDao;
import photo.dto.Photo;
import photo.service.face.PhotoService;
import user.dto.User;
import util.Paging;
import util.UserPaging;
import vo.GoodVO;

@Service
public class PhotoServiceImpl implements PhotoService{

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired private PhotoDao photoDao;
	@Autowired private CommentDao commentDao;
	@Autowired private HttpSession session;
	
	
	@Override
	public List<Photo> list(Paging paging) {
		return photoDao.selectAll(paging);
	}
	
	@Override
	public Paging getPaging(int curPage, Paging paging) {
		int totalCount = photoDao.selectCntAll(paging);
		logger.info("totalCount : {}",totalCount);
		if( totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		
		return pagingres;
	}

	@Override
	public List<Photo> listByCategory(Paging paging) {
		 return photoDao.listByCategory(paging);	

	}

	@Override
	public String getCategoryName(Integer categoryNo) {
		String cName = "";
		String str = photoDao.getCategoryName(categoryNo);
		
        if (str.contains(" - ")) {
            String[] parts = str.split(" - ");
            cName = parts[1];
        } else {
        	cName = str;
        }
		
		return cName;
	}

	@Override
	public List<Map<String, Object>> getuserRecommendRes(List<Photo> list) {
		return photoDao.getuserRecommendRes(list);

	}

	@Override
	public List<Category> categoryList() {
		return photoDao.categoryList();

	}

	@Override
	public int write(Photo photo) {
		return photoDao.write(photo);

	}

	@Override
	public Photo boardView(int boardNo) {
		return photoDao.selectBoardByBoardNo(boardNo);

	}

	@Override
	public int boardUpdate(Photo photo) {
		return photoDao.updateBoard(photo);

	}

	@Override
	public void commentDeleteAll(Comment comment) {
		commentDao.deleteCommentAll(comment);
		
	}

	@Override
	public void boardDelete(Photo deleteBoard) {
		photoDao.deleteBoard(deleteBoard);
		
	}

	@Override
	public void recommend(Photo recommendBoard) {
		int userno = (int)session.getAttribute("isLogin");
		int no = recommendBoard.getBoardNo();
		Good good = new Good(userno, no);
		
		if( photoDao.isRecomm(good) > 0 ) {
			photoDao.deleteRecommend(good);
			
		}else {
			photoDao.insertRecommend(good);
			
		}
		
	}

	@Override
	public RecommendRes getRecommendRes(Photo recommendBoard) {
		if( null != session.getAttribute("isLogin")) {
			Good good = new Good((int)this.session.getAttribute("isLogin"), recommendBoard.getBoardNo());
			return photoDao.getRecommendRes(good);
		}
		return null;
	}

	@Override
	public void deleteComment(ArrayList<Integer> boardno) {
		photoDao.deleteComment(boardno);
		
	}

	@Override
	public void deleteGood(ArrayList<Integer> boardno) {
		photoDao.deleteGood(boardno);
		
	}

	@Override
	public int listDeleteByBoardNo(ArrayList<Integer> boardno) {
		return photoDao.listDeleteByBoardNo(boardno);

	}

	@Override
	public Photo viewByBoardNo(int boardno) {
		photoDao.hit(boardno);
		return photoDao.select(boardno);
	}

	@Override
	public int viewRecommend(int boardno) {
		return photoDao.getRecommend(boardno);

	}

	@Override
	public GoodVO getRecommendVO(Good paramGood) {
		return photoDao.getRecommendVO(paramGood);

	}

	@Override
	public List<Comment> commentList(Board board) {
		return commentDao.selectCommentByBoardNo(board);

	}

	@Override
	public List<Photo> userByBoardList(Paging paging) {
		return photoDao.userByBoardList(paging);

	}

	@Override
	public Paging getPagingByUserNo(int curPage, Paging paging, User login) {
		int totalCount = photoDao.selectCntByUserNo(paging,login);
		logger.info("totalCount : {}",totalCount);
		if(totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		
		return pagingres;
	}

	@Override
	public Paging getPagingByUserNoGood(int curPage, Paging paging, User login) {
		int totalCount = photoDao.selectCntByUserNoGood(paging,login);
		logger.info("totalCount : {}",totalCount);
		if(totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		return pagingres;
	}

	@Override
	public List<Photo> userbyrecommList(Paging paging) {
		return photoDao.userbyrecommList(paging);

	}

	@Override
	public boolean isRecommend(HttpSession session, int boardno) {
		int res=0;
		if( null != session.getAttribute("userno")) {
			Good good = new Good((int)this.session.getAttribute("userno"), boardno);
			res = photoDao.isRecomm(good);
		}
		
		if( res > 0 ) {
			return true;
		}
		return false;
	}

	@Override
	public List<Photo> list() {
		return photoDao.list();

	}

	

	@Override
	public List<Map<String, Object>> getRecommendRes(Paging paging) {
		return photoDao.selectAllRecomm(paging);

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
	public List<Photo> boardList(int userno) {
		return photoDao.boardList(userno);

	}

	@Override
	public Comment commentByBoardNo(int commno) {
		return commentDao.commentByBoardNo(commno);

	}

	@Override
	public UserPaging getLogPaging(int curPage, UserPaging paging) {
		int totalCount = photoDao.selectLogCntAll(paging);

		UserPaging pagingres = new UserPaging(totalCount, curPage);

		return pagingres;
	}

	@Override
	public Paging getAdminPaging(int curPage, Paging paging) {
		int totalCount = photoDao.selectAdminCntAll(paging);
		
		Paging pagingres = new Paging(totalCount, curPage);

		return pagingres;
	}

	@Override
	public List<Photo> userrecommList(int userno) {
		return photoDao.userrecommList(userno);

	}

	@Override
	public String getCategoryName(int categoryNo) {
		String cName = "";
		String str = photoDao.getCategoryName(categoryNo);
		
        if (str.contains(" - ")) {
            String[] parts = str.split(" - ");
            cName = parts[1];
        } else {
        	cName = str;
        }
		
		return cName;
	}

	@Override
	public int category(Integer categoryNo) {
		return photoDao.category(categoryNo);

	}






	


	
	
}
