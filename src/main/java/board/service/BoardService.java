package board.service;

import board.dto.Board;
import board.dto.RecommendRes;
import comment.dto.Comment;
import util.Paging;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface BoardService {

	/**
	 * 게시글 목록 조회
	 * @param paging - 페이징 정보 객체
	 * @return 게시글 목록
	 */
	public List<Board> list(Paging paging);
	
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
	 * @return Board - 조회된 게시글
	 */
	public Board viewByBoardNo(int boardNo);

	public int write(Board board);

	public Board boardView(int boardNo);

	/**
	 * 입력된 제목과 글 내용으로 수정
	 * @param board - boardNo, title, content 를 담은 객체
	 * @return int - 영향을 받은 데이터 행 수
	 */
	public int boardUpdate(Board updateBoard);

	public void boardDelete(Board deleteBoard);

	public void recommend(Board recommendBoard);

	public boolean isRecommend(HttpSession session, int boardno);

	public RecommendRes getRecommendRes(Board recommendBoard);

	public List<Map<String, Object>> getRecommendRes(Paging paging);

	public int viewRecommend(int boardno);

	public List<Comment> commentList(Board board);

	public int commentInsert(Comment comment);

	public void commentDelete(Comment comment);

	public void listDelete(int boardno);


}