#include <DateTime.h>
#include <ESPDateTime.h>
#include <TimeElapsed.h>


#include <ESPDateTime.h>


#include <ESP8266WiFi.h>


//인터넷 시간 받아오는 코드
//그리고 추가사항으로 인터넷 연결 끊어지면 다시연결

//wifi
const char* ssid = "SK_WiFiGIGA04C6_2.4G";
const char* password = "1803003041";


unsigned long lastMs = 0;

unsigned long ms = millis();




void setup() {

  Serial.begin(115200); //전송속도

  Wifi_connect(); //와이파이 연결

  setupDateTime();
  Serial.println(DateTime.now());
  Serial.println(DateTime.getTime());
  Serial.println(DateTime.utcTime());
  Serial.println("--------------------");
  Serial.println(DateTime.toString());
  Serial.println(DateTime.toISOString());
  Serial.println(DateTime.toUTCString());
  Serial.println("--------------------");
  Serial.println(DateTime.format(DateFormatter::COMPAT));
  Serial.println(DateTime.format(DateFormatter::DATE_ONLY));
  Serial.println(DateTime.format(DateFormatter::TIME_ONLY));
  Serial.println("--------------------");
  DateTimeParts p = DateTime.getParts();
  Serial.printf("%04d/%02d/%02d %02d:%02d:%02d %ld %+05d\n", p.getYear(),
                p.getMonth(), p.getMonthDay(), p.getHours(), p.getMinutes(),
                p.getSeconds(), p.getTime(), p.getTimeZone());
  Serial.println("--------------------");
  time_t t = DateTime.now();
  Serial.println(DateFormatter::format("%Y/%m/%d %H:%M:%S", t));
  Serial.println(DateFormatter::format("%x - %I:%M %p", t));
  Serial.println(DateFormatter::format("Now it's %F %I:%M%p.", t));
}

void loop() {
  // put your main code here, to run repeatedly:
  if(WiFi.status() != WL_CONNECTED){ //연결이 이상할시에
    Serial.println("try reconnect");
    Wifi_connect();
  }
  Serial.println(DateTime.now());
  DateTimeParts p = DateTime.getParts();
  if(p.getMinutes() % 5 == 0 && p.getSeconds() == 0){
    Serial.println(DateTime.toString());
  }
  


  delay(1000);
}

void Wifi_connect() {
  
  Serial.println("---------------------------------------");
  Serial.println(ssid);
  WiFi.begin(ssid, password); // 와이파이 이름과 비밀번호를 통해 WIFI연결을 시작 // WL_CONNECTED라는 값을 돌려준다
  while (WiFi.status() != WL_CONNECTED) {
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
}

void setupDateTime() {
  // 와이파이 연결이후에 수정하세요
  // you can use custom timeZone,server and timeout
  DateTime.setTimeZone(9);
  //DateTime.setServer("asia.pool.ntp.org");
  DateTime.begin(15 * 1000);
  DateTime.setTimeZone(9);
  DateTime.begin();
  if (!DateTime.isTimeValid()) {
    Serial.println("Failed to get time from server.");
  }
}
