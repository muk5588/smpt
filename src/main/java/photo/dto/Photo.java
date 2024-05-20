package photo.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Photo {

	private int photono;
	private int boardno;
	private int categoryno;
	private int userno;
	private String title;
	private String content;
	private String nickname;
	private int boardview;
	private Date createdate;
	private Date updatedate;
	private MultipartFile photoFile;
	private String photoPath;
	private String filename;
	private String originalName;
	private String storedName;
	

	public Photo() {
		// TODO Auto-generated constructor stub
	}


	public Photo(int photono, int boardno, int categoryno, int userno, String title, String content, String nickname,
			int boardview, Date createdate, Date updatedate, MultipartFile photoFile, String photoPath, String filename,
			String originalName, String storedName) {
		super();
		this.photono = photono;
		this.boardno = boardno;
		this.categoryno = categoryno;
		this.userno = userno;
		this.title = title;
		this.content = content;
		this.nickname = nickname;
		this.boardview = boardview;
		this.createdate = createdate;
		this.updatedate = updatedate;
		this.photoFile = photoFile;
		this.photoPath = photoPath;
		this.filename = filename;
		this.originalName = originalName;
		this.storedName = storedName;
	}


	@Override
	public String toString() {
		return "Photo [photono=" + photono + ", boardno=" + boardno + ", categoryno=" + categoryno + ", userno="
				+ userno + ", title=" + title + ", content=" + content + ", nickname=" + nickname + ", boardview="
				+ boardview + ", createdate=" + createdate + ", updatedate=" + updatedate + ", photoFile=" + photoFile
				+ ", photoPath=" + photoPath + ", filename=" + filename + ", originalName=" + originalName
				+ ", storedName=" + storedName + "]";
	}


	public int getPhotono() {
		return photono;
	}


	public void setPhotono(int photono) {
		this.photono = photono;
	}


	public int getBoardno() {
		return boardno;
	}


	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}


	public int getCategoryno() {
		return categoryno;
	}


	public void setCategoryno(int categoryno) {
		this.categoryno = categoryno;
	}


	public int getUserno() {
		return userno;
	}


	public void setUserno(int userno) {
		this.userno = userno;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public int getBoardview() {
		return boardview;
	}


	public void setBoardview(int boardview) {
		this.boardview = boardview;
	}


	public Date getCreatedate() {
		return createdate;
	}


	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}


	public Date getUpdatedate() {
		return updatedate;
	}


	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}


	public MultipartFile getPhotoFile() {
		return photoFile;
	}


	public void setPhotoFile(MultipartFile photoFile) {
		this.photoFile = photoFile;
	}


	public String getPhotoPath() {
		return photoPath;
	}


	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public String getOriginalName() {
		return originalName;
	}


	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}


	public String getStoredName() {
		return storedName;
	}


	public void setStoredName(String storedName) {
		this.storedName = storedName;
	}
	
}