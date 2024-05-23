package QandA.service.QandAServiceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import QandA.dto.QandACategory;
import QandA.dao.QandADao;
import QandA.dto.Criteria;
import QandA.dto.SearchCriteria;
import QandA.dto.QandaVO;
import QandA.dto.ReplyQandaVO;
import QandA.service.QandAReplyService;
import QandA.service.QandAService;


@Service
public class QandAServiceImpl implements QandAService {
	
	@Inject
	private QandADao QandAdao;	//dao는 BoardDAO 객체임

	
	// 게시물 목록 가져오기 + 페이징-> list() 메서드 
	@Override
	public List<QandaVO> list(SearchCriteria scri) throws Exception {
		
		return QandAdao.list(scri);
	}
	
	
	// 검색 결과 갯수
	@Override
	public int countSearch(SearchCriteria scri) throws Exception {
		
		return QandAdao.countSearch(scri);
	}

	
	//페이징
		@Override
		public int listCount() throws Exception {
			
			return QandAdao.listCount();
		}
	
	
	
	//---------------------------------------------------------------------
	
	//게시물 작성 -> create() 메서드
	@Override
	public void create(QandaVO vo) throws Exception {
	
		QandAdao.create(vo);

	}
	
	
	
	//게시물 조회 -> detail() 메소드
	@Override
	public QandaVO detail(int boardNo) throws Exception {
		
		
		 return QandAdao.detail(boardNo);
	}
	
	

	
	// 게시글 수정 -> update() 메소드
	@Override
	public void update(QandaVO vo) throws Exception {
		QandAdao.update(vo);

	}

	
	
	//게시물 삭제
	@Override
	public void delete(int boardNo) throws Exception {
		// 먼저 추천 기록을 삭제합니다.( RECOMMEND_RECORD 테이블의 관련 레코드를 먼저 삭제 - 외래키때문)
		QandAdao.deleteRecommendRecords(boardNo);
        // 그런 다음 게시글을 삭제합니다.
		QandAdao.delete(boardNo);

	}

	
	
	///////////////////////////////////////////////////////////////////////
	
		// 추천 수 증가
		@Override
		public boolean incrementRecommendCount(int boardNo, int userno) throws Exception {
			if (!hasRecommended(userno, boardNo)) {
				QandAdao.incrementRecommendCount(boardNo);
				addRecommendRecord(userno, boardNo);
				return true;
			}
			return false;
		}

		

		
	//추천수 조회
	@Override
	public int getRecommendCount(int boardNo) throws Exception {
		return QandAdao.getRecommendCount(boardNo);
	}

	
	
	// 중복 추천 여부 확인
	@Override
	public boolean hasRecommended(int userno, int boardNo) throws Exception {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userno", userno);
	    params.put("boardNo", boardNo);
	    return QandAdao.hasRecommended(params) > 0;
	}

	// 추천 기록 추가
	@Override
    public void addRecommendRecord(int userno, int boardNo) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("userno", userno);
        params.put("boardNo", boardNo);
        QandAdao.addRecommendRecord(params);
    }
	
	@Override
	public void deleteRecommendRecords(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	
	// 조회수 증가 메소드
	@Override
	public void incrementViewCount(int boardNo) throws Exception {
		QandAdao.incrementViewCount(boardNo);
		
	}


	

	//게시판 분류 목록 조회
	@Override
    public List<QandACategory> getCategoryList() throws Exception {
        return QandAdao.getCategoryList();
    }


	@Override
	public List<ReplyQandaVO> replyList(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}




	
}
