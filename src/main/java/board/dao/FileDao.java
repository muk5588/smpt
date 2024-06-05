package board.dao;

import board.dto.BoardFile;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository("FileDao")
public interface FileDao {

	public void insert(BoardFile filetest);

	public int getFileCnt(int boardno);

	public BoardFile getFileByBoardNo(int boardno);

	public List<BoardFile> getFilesByBoardNo(int boardno);

	public void listDeleteByBoardNo(@Param("arr")ArrayList<Integer> boardno);

	public void setFile(@Param("files")ArrayList<BoardFile> files);

	public List<BoardFile> getFileList(int boardNo);

	public BoardFile getFileByFileNo(int fileNo);
	
	// 게시글 파일 수정 시 전 파일 삭제
	public void delete(int fileNo);
}
