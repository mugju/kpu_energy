#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>
#include <ESP8266WiFi.h> //와이파이
#include <stdio.h>

#include <DHT.h> //DHT11했던거 22도 동일한지는 모르겠음
#define DHTPIN D2
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

//전류센서
#define CURRENT 30


//wifi
const char* ssid = "SK_WiFiGIGA04C6_2.4G"; 
const char* password = "1803003041";

//sql 연결셋팅부
IPAddress server_addr(3,35,198,120);  // IP of the MySQL *server* here
//char hostname[] = "joljag.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com"; // change to your server's hostname/URL
char user[] = "root"; 
char password_[] = "Iotwhfwkr16";        // MySQL user login password

WiFiClient client;
MySQL_Connection conn(&client);
MySQL_Cursor* cursor;

char INSERT_SQL[] = "INSERT INTO test_arduino.hello_arduino (message) VALUES ('Hello, Arduino!')";

void setup(){
  Serial.begin(115200);
  
  Serial.println();
  Serial.println(ssid); 
  WiFi.begin(ssid, password); // 와이파이 이름과 비밀번호를 통해 WIFI연결을 시작하겠다 // WL_CONNECTED라는 값을 돌려준다 
  while(WiFi.status() != WL_CONNECTED){   
    // 네트워크의 연결 상태, 8개의 리턴값 
    // STATUS와 WL_CONNECTED 값이 같은지를 통해 제대로 연결이 되있는지를 확인할 수 있다 
    delay(500); 
    Serial.print("."); 
    } 
    
    Serial.println(); 
    Serial.println("Wifi connected!");
    Serial.println("\nConnected to network");
    Serial.print("My IP address is: ");
    Serial.println(WiFi.localIP());

    Serial.print("Connecting to SQL...  ");
    if (conn.connect(server_addr, 3306, user, password_)){
      Serial.println("OK.");
      }
    else{
    Serial.println("FAILED.");
    }
    // create MySQL cursor object
    cursor = new MySQL_Cursor(&conn);

}
 
void loop(){
    int h = dht.readHumidity();
    int t = dht.readTemperature();
    
    Serial.print("humidity:");          // ‘시리얼 플로터’ 사용위해 이 부분 주석 필요
    Serial.println(h);                  // 습도 값 출력
    Serial.print("temperature:");       // ‘시리얼 플로터’ 사용위해 이 부분 주석 필요
    Serial.println(t);                  // 온도 값 출력 
    
    //strcpy(INSERT_SQL,"INSERT INTO test.new_table VALUES (23,33)");
    sprintf(INSERT_SQL,"INSERT INTO test.new_table VALUES (%d,%d)",t,h);
    if (conn.connected()){
      cursor->execute(INSERT_SQL);
    }
    
    float volt = analogRead(A0) * (5.0 / 1024);
    float current = (volt - 2.5) * (CURRENT / 2);
    Serial.print("volt: \t");
    Serial.print(volt);
    Serial.print("  current: \t");
    Serial.print(current);
    Serial.println();
    
    delay(6000);
}
