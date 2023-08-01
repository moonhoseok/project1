package model;

import java.util.Date;
import java.sql.Time;

public class Day {
	private int msno;
	private String dmd;
	private String time1;
	private String time2;
	private String time3;
	public int getMsno() {
		return msno;
	}
	public void setMsno(int msno) {
		this.msno = msno;
	}
	public String getDmd() {
		return dmd;
	}
	public void setDmd(String dmd) {
		this.dmd = dmd;
	}
	public String getTime1() {
		return time1;
	}
	public void setTime1(String time1) {
		this.time1 = time1;
	}
	public String getTime2() {
		return time2;
	}
	public void setTime2(String time2) {
		this.time2 = time2;
	}
	public String getTime3() {
		return time3;
	}
	public void setTime3(String time3) {
		this.time3 = time3;
	}
	@Override
	public String toString() {
		return "Day [msno=" + msno + ", dmd=" + dmd + ", time1=" + time1 + ", time2=" + time2 + ", time3=" + time3
				+ "]";
	}
	
}
