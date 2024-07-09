package boardone;

import java.sql.Timestamp;

public class NoticeVO {
	private int num;
	private String subject;
	private int readcount;
	private Timestamp regdate;
	private String content;
	
	
	public NoticeVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public NoticeVO(int num, String subject, int readcount, Timestamp regdate, String content) {
		super();
		this.num = num;
		this.subject = subject;
		this.readcount = readcount;
		this.regdate = regdate;
		this.content = content;
	}

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "NoticeVO [num=" + num + ", subject=" + subject + ", readcount=" + readcount + ", regdate=" + regdate
				+ ", content=" + content + "]";
	}
	
	
}
