package org.kpu.team7.domain;

public class InquireDateVO {
	private int store_id;
	private int id;
	private String sDate;
	private String eDate;
	
	public int getStoreId() {
		return store_id;
	}
	
	public void setStoreId(int store_id) {
		this.store_id=store_id;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSDate() {
		return sDate;
	}

	public void setSDate(String sDate) {
		this.sDate = sDate;
	}

	public String getEDate() {
		return eDate;
	}

	public void setEDate(String eDate) {
		this.eDate = eDate;
	}
}
