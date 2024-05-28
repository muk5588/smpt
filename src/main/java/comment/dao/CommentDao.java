package comment.dao;

import board.dto.Board;
import comment.dto.Comment;
import Story.dto.Story;

import java.util.List;

import QandA.dto.QandA;

public interface CommentDao {

	public List<Comment> selectCommentByBoardNo(Board board);

	public int commentInsert(Comment comment);

	public void deleteComment(Comment comment);

	public void deleteCommentAll(Comment comment);

	public Comment commentByBoardNo(int commno);
	
	public List<Comment> selectCommentByBoardNo(QandA qanda);

	public List<Comment> selectCommentByBoardNo(Story story);

	

	
}
