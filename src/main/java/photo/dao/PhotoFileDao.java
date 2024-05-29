package photo.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import board.dto.BoardFile;
import photo.dto.PhotoFile;

public interface PhotoFileDao {

	public void insert(PhotoFile filetest);
	
	public int getFileCnt(int boardno);
	
	public PhotoFile getFileByBoardNo(int boardno);

	public void setFile(@Param("files") ArrayList<PhotoFile> files);

	public List<PhotoFile> getFileList(int boardNo);

	public void listDeleteByBoardNo(@Param("arr")ArrayList<Integer> boardno);

	public List<PhotoFile> getFilesByBoardNo(int boardno);

	public PhotoFile getFileByFileNo(int fileNo);

	
}
