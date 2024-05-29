package QandA.service;

import QandA.dao.QandADao;
import QandA.dto.*;
import comment.dao.CommentDao;
import comment.dto.Comment;
import user.dto.User;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import board.dto.Board;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import util.Paging;
import vo.GoodVO;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class QandAServiceImpl implements QandAService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired private QandADao qandaDao;
	@Autowired private CommentDao commentDao;
	@Autowired private HttpSession session;
	@Autowired private SqlSession sqlSession;
	
	@Override
	public List<QandA> list(Paging paging) {
		return qandaDao.selectAll(paging);
	}
	
	@Override
	public Paging getPaging(int curPage, Paging paging) {
		
		int totalCount = qandaDao.selectCntAll(paging);
		logger.info("totalCount : {}",totalCount);
		if( totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		
		return pagingres;
	}
	
	@Override
	public QandA viewByBoardNo(int boardno) {
		qandaDao.hit(boardno);
		return qandaDao.select(boardno);
	}

	@Override
	public int write(QandA qanda) {
		return qandaDao.write(qanda);
	}

	@Override
	public QandA QandAView(int boardNo) {
		return qandaDao.selectQandAByBoardNo(boardNo);
	}


	@Override
	public int QandAUpdate(QandA qanda) {
		return qandaDao.updateQandA(qanda);
	}

	@Override
	public void QandADelete(QandA deleteQandA) {
		qandaDao.deleteQandA(deleteQandA);
	}

	@Override
	public void recommend(QandA recommendQandA) {
		
		int userno = (int)session.getAttribute("isLogin");
		int no = recommendQandA.getBoardNo();
		Good good = new Good(userno, no);
		
		if( qandaDao.isRecomm(good) > 0 ) {
			qandaDao.deleteRecommend(good);
			
		}else {
			qandaDao.insertRecommend(good);
			
		}

	}

	@Override
	public boolean isRecommend(HttpSession session, int boardno) {
		int res=0;
		if( null != session.getAttribute("userno")) {
			Good good = new Good((int)this.session.getAttribute("userno"), boardno);
			res = qandaDao.isRecomm(good);
		}
		
		if( res > 0 ) {
			return true;
		}
		return false;
	}

	@Override
	public RecommendRes getRecommendRes(QandA recommendQandA) {
		if( null != session.getAttribute("isLogin")) {
			Good good = new Good((int)this.session.getAttribute("isLogin"), recommendQandA.getBoardNo());
			return qandaDao.getRecommendRes(good);
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> getRecommendRes(Paging paging) {
		return qandaDao.selectAllRecomm(paging);
	}

	@Override
	public int viewRecommend(int boardno) {
		return qandaDao.getRecommend(boardno);
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
		return qandaDao.listDeleteByBoardNo(boardno);
	}

	@Override
	public List<Category> categoryList() {
		return qandaDao.categoryList();
	}

	@Override
	public List<QandA> QandAList(int userno) {
		return qandaDao.QandAList(userno);
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

		int totalCount = qandaDao.selectLogCntAll(paging);

		Paging pagingres = new Paging(totalCount, curPage);

		return pagingres;
	}

	@Override
	public Paging getAdminPaging(int curPage, Paging paging) {
		int totalCount = qandaDao.selectAdminCntAll(paging);

		Paging pagingres = new Paging(totalCount, curPage);

		return pagingres;
	}

	@Override
	public List<QandA> userByQandAList(Paging paging) {
		return qandaDao.userByQandAList(paging);
	}

	@Override
	public List<QandA> userrecommList(int userno) {
		return qandaDao.userrecommList(userno);
	}

	@Override
	public void deleteComment(ArrayList<Integer> boardno) {
		qandaDao.deleteComment(boardno);
	}

	@Override
	public void deleteGood(ArrayList<Integer> boardno) {
		qandaDao.deleteGood(boardno);
	}

	@Override
	public GoodVO getRecommendVO(Good paramGood) {
		return qandaDao.getRecommendVO(paramGood);
	}

	@Override
	public List<QandA> listByCategory(Paging paging) {
		 return qandaDao.listByCategory(paging);	

	}

	@Override
	public List<Map<String, Object>> getuserRecommendRes(List<QandA> list) {
		return qandaDao.getuserRecommendRes(list);
	}

	@Override
	public String getCategoryName(int categoryNo) {
		String cName = "";
		String str = qandaDao.getCategoryName(categoryNo);
		
        if (str.contains(" - ")) {
            String[] parts = str.split(" - ");
            cName = parts[1];
        } else {
        	cName = str;
        }
		
		return cName;
	}

	@Override
	public List<QandA> list() {
		return qandaDao.list();
	}

	@Override
	public List<QandA> userbyrecommList(Paging paging) {
		return qandaDao.userbyrecommList(paging);
	}

	@Override
	public Paging getPagingByUserNo(int curPage, Paging paging, User login) {
		
		int totalCount = qandaDao.selectCntByUserNo(paging,login);
		logger.info("totalCount : {}",totalCount);
		if(totalCount <= 0) {
			return null;
		}
		Paging pagingres = new Paging(totalCount, curPage);
		
		return pagingres;
	}




}
