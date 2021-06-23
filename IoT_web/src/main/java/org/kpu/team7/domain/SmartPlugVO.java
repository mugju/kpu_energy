package org.kpu.team7.domain;

import java.util.Date;

public class SmartPlugVO {
	private Date datetime;
	private Double amp;

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	public Double getAmp() {
		return amp;
	}

	public void setAmp(Double amp) {
		this.amp = amp;
	}
	
	@Override
	public String toString() {
		return "SmartPlug [datetime=" + datetime + ", amp=" + amp + "]";
	}
}
