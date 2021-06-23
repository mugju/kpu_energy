package org.kpu.team7.domain;

public class InquireDateVO {
	private int store_id;
	private int id;
	private String date;
	
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

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}