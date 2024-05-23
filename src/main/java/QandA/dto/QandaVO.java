package QandA.dto;

import java.util.Date;
import java.util.List;

public class QandaVO {

	private int boardNo;        // 게시판 번호
    private int CategoryNo;      // 케시판 분류 번호
    private int userno;      // 회원번호
    private String nickname;    // 닉네임
    private String title;  // 제목
    private String content; // 내용
    private Date createDate; // 작성일
    private Date updateDate; // 수정일
    private int boardview; //조회수
    private int recommendCount; //추천수

	private String imagePath;	//이미지
    
    private List<String> imagePaths; // 이미지 여러개? 경로 리스트(아직 구현X)
    
    public QandaVO() {}

	public QandaVO(int boardNo, int categoryNo, int userno, String nickname, String title, String content,
			Date createDate, Date updateDate, int boardview, String imagePath) {
		super();
		this.boardNo = boardNo;
		CategoryNo = categoryNo;
		this.userno = userno;
		this.nickname = nickname;
		this.title = title;
		this.content = content;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.boardview = boardview;
		this.imagePath = imagePath;
	}
    
    

	@Override
	public String toString() {
		return "StoryVO [boardNo=" + boardNo + ", CategoryNo=" + CategoryNo + ", userno=" + userno + ", nickname="
				+ nickname + ", title=" + title + ", content=" + content + ", createDate=" + createDate
				+ ", updateDate=" + updateDate + ", boardview=" + boardview + ", imagePath=" + imagePath + "]";
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getCategoryNo() {
		return CategoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		CategoryNo = categoryNo;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public int getBoardview() {
		return boardview;
	}

	public void setBoardview(int boardview) {
		this.boardview = boardview;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public List<String> getImagePaths() {
		return imagePaths;
	}


	public void setImagePaths(List<String> imagePaths) {
		this.imagePaths = imagePaths;
	}

	
	public int getRecommendCount() {
		return recommendCount;
	}


	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}
    
    
    
	
}
