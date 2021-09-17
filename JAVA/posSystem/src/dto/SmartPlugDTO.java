package dto;

public class SmartPlugDTO {
	private String datetime;
	private Double amp;

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
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
		return "SmartPlugDTO [datetime=" + datetime + ", amp=" + amp + "]";
	}
}
