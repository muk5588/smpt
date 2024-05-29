package Story.service;


import comment.dto.Comment;
import Story.dto.Story;
import user.dto.User;
import util.Paging;
import vo.GoodVO;

import javax.servlet.http.HttpSession;

import board.dto.Category;
import board.dto.Good;
import board.dto.RecommendRes;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface StoryService {

	/**
	 * 게시글 목록 조회
	 * @param paging - 페이징 정보 객체
	 * @return 게시글 목록
	 */
	public List<Story> list(Paging paging);
	
	/**
	 * 게시글 목록을 위한 페이징 객체를 생성
	 * 
	 * 전달 파라미터의 curPage - 현재 페이지
	 * DB에서 조회한 totalCount - 총 게시글 수
	 * 
	 * 두 가지 데이터를 활용하여 페이징 객체를 생성하고 반환
	 * 
	 * @param curPage - 현재 페이지 번호
	 * @param paging 
	 * @return 페이징 계산이 완료된 객체
	 */
	public Paging getPaging(int curPage, Paging paging);
	
	/**
	 * 게시글 번호로 조회
	 * @param boardNo - 게시글 번호
	 * @return Story - 조회된 게시글
	 */
	public Story viewByBoardNo(int boardNo);

	public int write(Story story);

	public Story StoryView(int boardNo);

	/**
	 * 입력된 제목과 글 내용으로 수정
	 * @param story - boardNo, title, content 를 담은 객체
	 * @return int - 영향을 받은 데이터 행 수
	 */
	public int StoryUpdate(Story updateStory);

	public void StoryDelete(Story deleteStory);

	public void recommend(Story recommendStory);

	public boolean isRecommend(HttpSession session, int boardno);

	public RecommendRes getRecommendRes(Story recommendStory);

	public List<Map<String, Object>> getRecommendRes(Paging paging);

	public int viewRecommend(int boardno);

	public List<Comment> commentList(Story story);

	public int commentInsert(Comment comment);

	public void commentDelete(Comment comment);

	public int listDeleteByBoardNo(ArrayList<Integer> boardno);


    public List<Category> categoryList();

	public List<Story> StoryList(int userno);

	public void commentDeleteAll(Comment comment);

    public Comment commentByBoardNo(int commno);

	public Paging getLogPaging(int curPage, Paging paging);

    public Paging getAdminPaging(int curPage, Paging paging);

	public List<Story> userByStoryList(Paging paging);

	public List<Story> userrecommList(int userno);

	public void deleteComment(ArrayList<Integer> boardno);

	public void deleteGood(ArrayList<Integer> boardno);

	public GoodVO getRecommendVO(Good paramGood);

	public List<Story> listByCategory(Paging paging);

	/**
	 * 보드 리스트로 좋아요 수 조회
	 * @param list - 게시글 List
	 * @return - ( 게시글번호, 게시글 제목, 좋아요 수 )
	 */
	public List<Map<String, Object>> getuserRecommendRes(List<Story> list);

	/**
	 * 카테고리 번호로 카테고리 이름 조회.
	 * @param categoryNo
	 * @return
	 */
	public String getCategoryName(int categoryNo);

	public List<Story> list();

	public List<Story> userbyrecommList(Paging paging);

	/**
	 * 유저객체를 이용한 게시글 목록 페이징 
	 * @param curPage - 현재 페이지 번호
	 * @param paging - 페이징 객체
	 * @param login - 유저 객체
	 * @return - 페이징 객체
	 */
	public Paging getPagingByUserNo(int curPage, Paging paging, User login);
}