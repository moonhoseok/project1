package model;

import java.util.Date;

public class Reservation {
	private int rno;
	private String id;
	private String rmtitle;
	private int rmsno;
	private String rmd;
	private String rtime;
	private Date rpmdate;
	private int rtprice;
	private String rseat1;
	private String rseat2;
	private String rseat3;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRmtitle() {
		return rmtitle;
	}
	public void setRmtitle(String rmtitle) {
		this.rmtitle = rmtitle;
	}
	public int getRmsno() {
		return rmsno;
	}
	public void setRmsno(int rmsno) {
		this.rmsno = rmsno;
	}
	public String getRmd() {
		return rmd;
	}
	public void setRmd(String rmd) {
		this.rmd = rmd;
	}
	public String getRtime() {
		return rtime;
	}
	public void setRtime(String rtime) {
		this.rtime = rtime;
	}
	public Date getRpmdate() {
		return rpmdate;
	}
	public void setRpmdate(Date rpmdate) {
		this.rpmdate = rpmdate;
	}
	public int getRtprice() {
		return rtprice;
	}
	public void setRtprice(int rtprice) {
		this.rtprice = rtprice;
	}
	public String getRseat1() {
		return rseat1;
	}
	public void setRseat1(String rseat1) {
		this.rseat1 = rseat1;
	}
	public String getRseat2() {
		return rseat2;
	}
	public void setRseat2(String rseat2) {
		this.rseat2 = rseat2;
	}
	public String getRseat3() {
		return rseat3;
	}
	public void setRseat3(String rseat3) {
		this.rseat3 = rseat3;
	}
	@Override
	public String toString() {
		return "Reservation [rno=" + rno + ", id=" + id + ", rmtitle=" + rmtitle + ", rmsno=" + rmsno + ", rmd=" + rmd
				+ ", rtime=" + rtime + ", rpmdate=" + rpmdate + ", rtprice=" + rtprice + ", rseat1=" + rseat1
				+ ", rseat2=" + rseat2 + ", rseat3=" + rseat3 + "]";
	}
	
	
	
}
