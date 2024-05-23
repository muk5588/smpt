package QandA.dto;

import java.util.Date;

public class ReplyQandaVO {
	
	private int boardNo;
	private int rno;
	private int userno;
	private String content;
	private String nickname;
	private Date createDate;
	
	
	@Override
	public String toString() {
		return "ReplyQandaVO [boardNo=" + boardNo + ", rno=" + rno + ", userno=" + userno + ", content=" + content
				+ ", nickname=" + nickname + ", createDate=" + createDate + "]";
	}
	
	
	
	public ReplyQandaVO(int boardNo, int rno, int userno, String content, String nickname, Date createDate) {
		super();
		this.boardNo = boardNo;
		this.rno = rno;
		this.userno = userno;
		this.content = content;
		this.nickname = nickname;
		this.createDate = createDate;
	}
	
	
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getUserno() {
		return userno;
	}
	public void setUserno(int userno) {
		this.userno = userno;
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
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	
	
	
	
}
