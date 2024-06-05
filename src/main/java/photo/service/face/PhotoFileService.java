package photo.service.face;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import board.dto.BoardFile;
import photo.dto.Photo;
import photo.dto.PhotoFile;

public interface PhotoFileService {

	public List<String> extractOriginName(String content);

	public List<String> extractStoredName(String content, List<String> originNames);

	public void setFile(ArrayList<PhotoFile> files);

	public void filesave(Photo photo, MultipartFile file);

	public PhotoFile fileTempSave(HttpServletRequest request, HttpServletResponse response);

	public List<PhotoFile> getFileList(int boardNo);

	public void listDeleteByBoardNo(ArrayList<Integer> boardno);

	public List<PhotoFile> getFilesByBoardNo(int boardno);

	public PhotoFile getFileByFileNo(int fileNo);

	public void deleteFile(int fileNo);

}
