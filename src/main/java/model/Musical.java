package model;

public class Musical {
	private int msno;
	private String mtitle;
	private String mage;
	private String mdate;
	private String mtime;
	private String mcast;
	private String mpd;
	private String mpos;
	private String mvid;
	
	public int getMsno() {
		return msno;
	}
	public void setMsno(int msno) {
		this.msno = msno;
	}
	public String getMtitle() {
		return mtitle;
	}
	public void setMtitle(String mtitle) {
		this.mtitle = mtitle;
	}
	public String getMage() {
		return mage;
	}
	public void setMage(String mage) {
		this.mage = mage;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	public String getMtime() {
		return mtime;
	}
	public void setMtime(String mtime) {
		this.mtime = mtime;
	}
	public String getMcast() {
		return mcast;
	}
	public void setMcast(String mcast) {
		this.mcast = mcast;
	}
	public String getMpd() {
		return mpd;
	}
	public void setMpd(String mpd) {
		this.mpd = mpd;
	}
	public String getMpos() {
		return mpos;
	}
	public void setMpos(String mpos) {
		this.mpos = mpos;
	}
	
	public String getMvid() {
		return mvid;
	}
	public void setMvid(String mvid) {
		this.mvid = mvid;
	}
	@Override
	public String toString() {
		return "Musical [msno=" + msno + ", mtitle=" + mtitle + ", mage=" + mage + ", mdate=" + mdate + ", mtime="
				+ mtime + ", mcast=" + mcast + ", mpd=" + mpd + ", mpos=" + mpos + ", mvid=" + mvid + "]";
	}
	
}
