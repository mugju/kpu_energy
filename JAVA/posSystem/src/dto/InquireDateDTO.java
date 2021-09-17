package dto;

public class InquireDateDTO {
	private String date;
	private int id;
	private int store_id;

	public InquireDateDTO(String date, int id, int store_id) {
		this.date = date;
		this.id = id;
		this.store_id = store_id;
	}

	public int getId() {
		return id;
	}

	public String getDate() {
		return date;
	}

	public int getStore_id() {
		return store_id;
	}

	@Override
	public String toString() {
		return "InquireDateDTO [date=" + date + ", id=" + id + ", store_id" + store_id + "]";
	}
}
