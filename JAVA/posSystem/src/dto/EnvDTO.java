package dto;

import java.util.Date;

public class EnvDTO {
	private Date datetime;
	private int people;
	
	public void setDatetime(Date datetime) {
		this.datetime=datetime;
	}
	public Date getDatetime() {
		return datetime;
	}
	
	public void setPeople(int people) {
		this.people=people;
	}
	public int getPeople() {
		return people;
	}
	
	@Override
	public String toString() {
		return "EnvDTO [datetime=" + datetime + ", people=" + people + "]";
	}
}
