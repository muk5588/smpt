package QandA.dao;

import QandA.dto.*;
import user.dto.User;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;
import util.Paging;
import vo.GoodVO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository("QandADao")
public interface QandADao {

	/**
	 * 게시판의 전체 게시글을 DB에서 조회
	 * 
	 * @param paging - 페이징 정보 객체
	 * @return 게시글 전체 리스트
	 */
	public List<QandA> selectAll(Paging paging);
	/**
	 * 전체 개수 조회
	 * @param paging 
	 * @return
	 */
	public int selectCntAll(Paging paging);

	public QandA select(int boardno);

	public void hit(int boardno);

	public int write(QandA qanda);

	public QandA selectQandAByBoardNo(int boardNo);

	public int updateQandA(QandA qanda);

	/**
	 * 게시글을 삭제 한다
	 * @param deleteStory - 삭제하려는 게시글 번호를 가진 DTO 객체
	 */
	public void deleteQandA(QandA deleteQandA);

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

	public List<QandA> selectBySearch(Paging paging);

	public int listDeleteByBoardNo(@Param("arr")ArrayList<Integer> boardno);


    public List<Category> categoryList();

	public List<QandA> QandAList(@Param("userNo")int userNo);

	public int selectLogCntAll(Paging paging);

    public int selectAdminCntAll(Paging paging);

    public List<QandA> userByQandAList(Paging paging);

	public List<QandA> userrecommList(int userno);

	public void deleteComment(@Param("arr")ArrayList<Integer> boardno);

	public void deleteGood(@Param("arr")ArrayList<Integer> boardno);

	public GoodVO getRecommendVO(Good paramGood);

	public List<QandA> listByCategory(Paging paging);

    public List<Map<String, Object>> getuserRecommendRes(@Param("arr")List<QandA> list);

	public String getCategoryName(int categoryNo);

    public List<QandA> list();

	public List<QandA> userbyrecommList(Paging paging);

	public int selectCntByUserNo(@Param("paging")Paging paging, @Param("user")User login);
	
	public int category(Integer categoryNo);
}
