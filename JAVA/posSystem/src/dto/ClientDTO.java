package dto;

public class ClientDTO {
	private String id;
	private int store_id;
	private String passwd;

	public int getStoreId() {
		return store_id;
	}

	public void setStoreId(int store_id) {
		this.store_id = store_id;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	@Override
	public String toString() {
		return "ClientDTO [store_id=" + store_id + ", id=" + id + ", passwd=" + passwd + "]";
	}
}
