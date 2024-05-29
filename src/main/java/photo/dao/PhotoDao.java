package photo.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import board.dto.Board;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import photo.dto.Photo;
import user.dto.User;
import util.Paging;
import util.UserPaging;
import vo.GoodVO;

public interface PhotoDao {

	public List<Photo> selectAll(Paging paging);

	public int selectCntAll(Paging paging);

	public List<Photo> listByCategory(Paging paging);

	public String getCategoryName(Integer categoryNo);

	public List<Map<String, Object>> getuserRecommendRes(@Param("arr")List<Photo> list);
//
	public List<Map<String, Object>> selectAllRecomm(Paging paging);
//
	public List<Category> categoryList();

	public int write(Photo photo);

	public Photo selectBoardByBoardNo(int boardNo);

	public int updateBoard(Photo photo);

	public void deleteBoard(Photo deleteBoard);

	public RecommendRes getRecommendRes(Good good);

	public int isRecomm(Good good);

	public void deleteRecommend(Good good);

	public void insertRecommend(Good good);

	public void deleteComment(@Param("arr")ArrayList<Integer> boardno);

	public void deleteGood(@Param("arr")ArrayList<Integer> boardno);

	public int listDeleteByBoardNo(@Param("arr")ArrayList<Integer> boardno);
//여기부터
	public void hit(int boardno);

	public Photo select(int boardno);

	public int getRecommend(int boardno);

	public GoodVO getRecommendVO(Good paramGood);

	public List<Photo> userByBoardList(Paging paging);

	public int selectCntByUserNo(@Param("paging")Paging paging, @Param("user")User login);

	public int selectCntByUserNoGood(@Param("paging")Paging paging, @Param("user")User login);

	public List<Photo> userbyrecommList(Paging paging);

	public List<Photo> list();

	//
	public int selectCntTitleBySearch(String search);

	public List<Photo> selectBySearch(Paging paging);
	
	public List<Photo> boardList(@Param("userNo")int userNo);

	public int selectLogCntAll(UserPaging paging);

    public int selectAdminCntAll(Paging paging);

	public String getCategoryName(int categoryNo);

    public int category(Integer categoryNo);

	public List<Photo> userrecommList(int userno);





}
