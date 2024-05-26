package QandA.dao;

import java.util.List;

import QandA.dto.ReplyQandaVO;

public interface ReplyQandADao {
	
	// 댓글 조회
	public List<ReplyQandaVO> replyList(int boardNo) throws Exception;

	// 댓글 조회
	public void replyWrite(ReplyQandaVO vo) throws Exception;

	// 댓글 수정
	public void replyModify(ReplyQandaVO vo) throws Exception;

	// 댓글 삭제
	public void replyDelete(ReplyQandaVO vo) throws Exception;
	
	// 단일 댓글 조회
		public ReplyQandaVO replySelect(ReplyQandaVO vo) throws Exception;
	

}
