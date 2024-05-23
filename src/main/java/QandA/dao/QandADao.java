package QandA.dao;

import java.util.List;
import java.util.Map;

import QandA.dto.QandACategory;
import QandA.dto.Criteria;
import QandA.dto.SearchCriteria;
import QandA.dto.QandaVO;

public interface QandADao {

	// 게시물 목록 조회 + 페이징
	public List<QandaVO> list(SearchCriteria scri) throws Exception;

	// 게시글 목록 + 페이징 + 검색
	// public List<StoryVO> listSearch(SearchCriteria scri) throws Exception;

	// 검색 결과 갯수
	public int countSearch(SearchCriteria scri) throws Exception;

	// 게시물 총 개수(페이징)
	public int listCount() throws Exception;

	// 게시물 작성
	public void create(QandaVO vo) throws Exception;

	// 게시물 조회
	public QandaVO detail(int boardNo) throws Exception;

	// 게시물 수정
	public void update(QandaVO vo) throws Exception;

	// 게시뮬 삭제
	public void delete(int boardNo) throws Exception;

	///////////////////////////////////////////////////////////////////////////////////////

	// 추천 수 증가
	public void incrementRecommendCount(int boardNo) throws Exception;

	// 추천 수 조회
	public int getRecommendCount(int boardNo) throws Exception;

	// 중복 추천 여부 확인
	public int hasRecommended(Map<String, Object> params) throws Exception;

	// 추천 기록 추가
	public void addRecommendRecord(Map<String, Object> params) throws Exception;
	
	
	//추천 기록 삭제(RECOMMEND_RECORD의 boardNo가 story테이블의 boardNo가 외래키 참조되있어서 먼저 삭제해야 게시글 지워짐)
	public void deleteRecommendRecords(int boardNo) throws Exception;

	///////////////////////////////////////////////////////////////////////////////////////

	// 조회수 증가
	public void incrementViewCount(int boardNo) throws Exception;
	
	
	//게시판 분류 목록 조회
	public List<QandACategory> getCategoryList() throws Exception;
	

}
