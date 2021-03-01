/**
 * 
 */
package com.testSpring.model;

/**
 * @author ASUS UX534FTC
 *
 */
// HomeVo는 모델/ 모델을 만들어 주는 이유 -> 여기에 데이터를 담아서 데이터 베이스에 들어가기 편하게끔 보내주거나, 데이터 베이스에서 결과를 여기에 담아서 가져온다.
public class HomeVo {

	private int id;
	private String name;
	private String location;
	private String datetime;
	private float temp;
	private float humid;
	private String electric;

	
	//파라미터 없는 생성자   alt + shift + s -> Generate Constructer using field -> 모두 deselect all 해서 generate
	public HomeVo() {
		super(); // 모든 클래스는 Object라는 객체에서 상속을 받는다. -> 상속 받은 애는 무조건 생성자에서 위(상속해주는 애의 생성자를 실행해야 한다.)에 있는 생성자까지 올라가야 한다.
		// -> super(); 가 뜻하는게 ->상속해준 바로 위의 객체의 생성자를 의미(결국에는 바로위로 건너 건너 올라가 결국에는 object의 생성자로 도달하게 된다.)(결국에는 Object의 생성자를 뜻함)
	}



	//파라미터 있는 생성자 alt + shift + s -> Generate Constructer using field -> 모두 select all 해서 generate 모든 파라미터가 있는 생성자를 만든다.
	public HomeVo(int id, String name, String location, String datetime, float temp, float humid, String electric) {
		super();
		this.id = id; // this는 위에 private int id; 의 id id의 색갈로 구분할 수 있다. 파랑/검정
		this.name = name;
		this.location = location;
		this.datetime = datetime;
		this.temp = temp;
		this.humid = humid;
		this.electric = electric;
	}

	//getter and setter -> generate
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getDatetime() {
		return datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public float getTemp() {
		return temp;
	}

	public void setTemp(float temp) {
		this.temp = temp;
	}

	public float getHumid() {
		return humid;
	}

	public void setHumid(float humid) {
		this.humid = humid;
	}

	public String getElectric() {
		return electric;
	}

	public void setElectric(String electric) {
		this.electric = electric;
	}

	@Override
	public String toString() {
		return "HomeVo [id=" + id + ", name=" + name + ", location=" + location + ", datetime=" + datetime + ", temp="
				+ temp + ", humid=" + humid + ", electric=" + electric + "]";
	}// 크게 중요한 건 아님 ctrl + shift + s -> generate toString() 원래는 객체를 ->
		// System.out.println(객체) -> ;#$%234126481 -> 객채{id = 3, name = 에어컨

}
