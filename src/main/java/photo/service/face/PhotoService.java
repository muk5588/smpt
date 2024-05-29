package photo.service.face;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import board.dto.Board;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import comment.dto.Comment;
import photo.dto.Photo;
import user.dto.User;
import util.Paging;
import util.UserPaging;
import vo.GoodVO;

public interface PhotoService  {


	public List<Photo> list(Paging paging);
	
	public Paging getPaging(int curPage, Paging paging);

	public List<Photo> listByCategory(Paging paging);

	public String getCategoryName(Integer categoryNo);

	public List<Map<String, Object>> getuserRecommendRes(List<Photo> list);

	public List<Category> categoryList();

	public int write(Photo photo);

	public Photo boardView(int boardNo);
//
	public int boardUpdate(Photo updateBoard);
//
	public void commentDeleteAll(Comment comment);
//
	public void boardDelete(Photo deleteBoard);
//
	public void recommend(Photo recommendBoard);
	//
	public List<Photo> list();

	public RecommendRes getRecommendRes(Photo recommendBoard);

	public void deleteComment(ArrayList<Integer> boardno);

	public void deleteGood(ArrayList<Integer> boardno);

	public int listDeleteByBoardNo(ArrayList<Integer> boardno);

	public Photo viewByBoardNo(int boardno);

	public int viewRecommend(int boardno);

	public GoodVO getRecommendVO(Good paramGood);


	public List<Photo> userByBoardList(Paging paging);

	public Paging getPagingByUserNo(int curPage, Paging paging, User login);

	public Paging getPagingByUserNoGood(int curPage, Paging paging, User login);

	public List<Photo> userbyrecommList(Paging paging);

	//
	public boolean isRecommend(HttpSession session, int boardno);

	//
	public List<Map<String, Object>> getRecommendRes(Paging paging);

	public int commentInsert(Comment comment);

	public void commentDelete(Comment comment);

	public List<Photo> boardList(int userno);

    public Comment commentByBoardNo(int commno);

	public UserPaging getLogPaging(int curPage, UserPaging paging);

    public Paging getAdminPaging(int curPage, Paging paging);

	public List<Photo> userrecommList(int userno);

	public String getCategoryName(int categoryNo);

    public int category(Integer categoryNo);

	List<Comment> commentList(Board board);

	
    
	


	
}
