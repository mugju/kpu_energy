package org.kpu.team7.domain;

import java.util.Date;

public class SmartPlugVO {

	private int id;
	private Date datetime;
	private int store_id;
	private Double amp;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	public int getStoreId() {
		return store_id;
	}

	public void setStoreId(int store_id) {
		this.store_id = store_id;
	}

	public Double getAmp() {
		return amp;
	}

	public void setAmp(Double amp) {
		this.amp = amp;
	}
	
	@Override
	public String toString() {
		return "SmartPlug [id=" + id + ", datetime=" + datetime + ", store_id=" + store_id + ", amp=" + amp + "]";
	}
}
