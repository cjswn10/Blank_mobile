package com.blank.vo;

public class LogVo {

	private int lno;
	private String ip;
	private String ldate;
	private String id;
	public LogVo(int lno, String ip, String ldate, String id) {
		super();
		this.lno = lno;
		this.ip = ip;
		this.ldate = ldate;
		this.id = id;
	}
	public LogVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getLno() {
		return lno;
	}
	public void setLno(int lno) {
		this.lno = lno;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getLdate() {
		return ldate;
	}
	public void setLdate(String ldate) {
		this.ldate = ldate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
