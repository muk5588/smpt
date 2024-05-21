package QandA.dto;

import java.util.Date;

public class QandA {
    private int id;          // 글 번호
    private int seq; 	     // seq번호
    private int userno;      // 작성자 사용자 번호
    private int cateno;      // 게시판 종류 코드
    private String title;    // 게시글 제목
    private String content;  // 게시글 본문
    private Date createDate; // 작성일
    private Date updateDate; // 수정일
    private int views;       // 조회수
    private int good;        // 추천수
    private String userid;   // 작성자 아이디
    private String imagePath; // 이미지 파일 경로
    private String attachmentPath; // 첨부파일 경로

    // 기본 생성자
    public QandA() {
    }

	@Override
	public String toString() {
		return "QandA [id=" + id + ", seq=" + seq + ", userno=" + userno + ", cateno=" + cateno + ", title=" + title
				+ ", content=" + content + ", createDate=" + createDate + ", updateDate=" + updateDate + ", views="
				+ views + ", good=" + good + ", userid=" + userid + ", imagePath=" + imagePath + ", attachmentPath="
				+ attachmentPath + "]";
	}

	public QandA(int id, int seq, int userno, int cateno, String title, String content, Date createDate,
			Date updateDate, int views, int good, String userid, String imagePath, String attachmentPath) {
		super();
		this.id = id;
		this.seq = seq;
		this.userno = userno;
		this.cateno = cateno;
		this.title = title;
		this.content = content;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.views = views;
		this.good = good;
		this.userid = userid;
		this.imagePath = imagePath;
		this.attachmentPath = attachmentPath;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public int getCateno() {
		return cateno;
	}

	public void setCateno(int cateno) {
		this.cateno = cateno;
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

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getGood() {
		return good;
	}

	public void setGood(int good) {
		this.good = good;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getAttachmentPath() {
		return attachmentPath;
	}

	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}

	

}