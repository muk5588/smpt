package QandA.service.QandAServiceImpl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import QandA.dao.ReplyQandADao;
import QandA.dto.ReplyQandaVO;
import QandA.service.QandAReplyService;

@Service
public class QandAReplyServiceImpl implements QandAReplyService {
	
	@Inject
	private ReplyQandADao qandareplydao;

	@Override
	public List<ReplyQandaVO> replyList(int boardNo) throws Exception {
		
		return  qandareplydao.replyList(boardNo);
	}

	@Override
	public void replyWrite(ReplyQandaVO vo) throws Exception {
		 qandareplydao.replyWrite(vo);
	}

	@Override
	public void replyModify(ReplyQandaVO vo) throws Exception {
		 qandareplydao.replyModify(vo);
	}

	@Override
	public void replyDelete(ReplyQandaVO vo) throws Exception {
		 qandareplydao.replyDelete(vo);
	}
	
	// 단일 댓글 조회
		@Override
		public ReplyQandaVO replySelect(ReplyQandaVO vo) throws Exception {
		    return  qandareplydao.replySelect(vo);
		}

	
	
	

}
