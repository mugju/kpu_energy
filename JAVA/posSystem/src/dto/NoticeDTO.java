package dto;

public class NoticeDTO {
	private String datetime;
	private String contents;
	
	public String getDate() {
		return datetime;
	}
	public void setDate(String datetime) {
		this.datetime = datetime;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "NoticeDTO [date: "+datetime+", content: "+contents+"]";
	}
}
