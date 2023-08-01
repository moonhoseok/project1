package model;

import java.util.Date;

public class Comment {
	private int msno;
	private String id;
	private String ccontent;
	private int cstar;
	private Date cdate;
	public int getMsno() {
		return msno;
	}
	public void setMsno(int msno) {
		this.msno = msno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
	public int getCstar() {
		return cstar;
	}
	public void setCstar(int cstar) {
		this.cstar = cstar;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	@Override
	public String toString() {
		return "Comment [msno=" + msno + ", id=" + id + ", ccontent=" + ccontent + ", cstar=" + cstar + ", cdate="
				+ cdate + "]";
	}
	
}
