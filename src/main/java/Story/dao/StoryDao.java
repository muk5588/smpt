package Story.dao;


import user.dto.User;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import board.dto.BoardFile;
import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import Story.dto.Story;
import util.Paging;
import vo.GoodVO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("StoryDao")
public interface StoryDao {

	/**
	 * 게시판의 전체 게시글을 DB에서 조회
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return 게시글 전체 리스트
	 */
	public List<Story> selectAll(Paging paging);
	/**
	 * 전체 개수 조회
	 * @param paging 
	 * @return
	 */
	public int selectCntAll(Paging paging);

	public Story select(int boardno);

	public void hit(int boardno);

	public int write(Story story);

	public Story selectStoryByBoardNo(int boardNo);

	public int updateStory(Story story);

	/**
	 * 게시글을 삭제 한다
	 * @param deleteStory - 삭제하려는 게시글 번호를 가진 DTO 객체
	 */
	public void deleteStory(Story deleteStory);

	/**
	 * 추천
	 * @param conn
	 * @param Good
	 */
	public void insertRecommend(Good good);

	public int isRecomm(Good good);

	public void deleteRecommend(Good good);

	public RecommendRes getRecommendRes(Good good);

	public List<Map<String, Object>> selectAllRecomm(Paging paging);

	public int getRecommend(int boardno);

	public int selectCntTitleBySearch(String search);

	public List<Story> selectBySearch(Paging paging);

	public int listDeleteByBoardNo(@Param("arr")ArrayList<Integer> boardno);


    public List<Category> categoryList();

	public List<Story> StoryList(@Param("userNo")int userNo);

	public int selectLogCntAll(Paging paging);

    public int selectAdminCntAll(Paging paging);

    public List<Story> userByStoryList(Paging paging);

	public List<Story> userrecommList(int userno);

	public void deleteComment(@Param("arr")ArrayList<Integer> boardno);

	public void deleteGood(@Param("arr")ArrayList<Integer> boardno);

	public GoodVO getRecommendVO(Good paramGood);

	public List<Story> listByCategory(Paging paging);

    public List<Map<String, Object>> getuserRecommendRes(@Param("arr")List<Story> list);

	public String getCategoryName(int categoryNo);

    public List<Story> list();

	public List<Story> userbyrecommList(Paging paging);

	public int selectCntByUserNo(@Param("paging")Paging paging, @Param("user")User login);
	
	public List<BoardFile> getFilesByBoardNo(int boardNo);
	
	public void insert(BoardFile boardFile);
   
}
