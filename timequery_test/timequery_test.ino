// 자동정렬은 ctrl + T
// 일단 시간 조작해서 넣는것은 성공. 해당 코드 복붙해서 메모장에 보관할것!
//이 코듸의 경우 달을 표시하는거에서 처음시작이 1월이 아닌 0월로 나와 수정
//mysql 연결관련 헤더
#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>

#include <ESP8266WiFi.h> //와이파이
#include <stdio.h>


//시간 관련 헤더
#include <DateTime.h>
#include <ESPDateTime.h>
#include <TimeElapsed.h>

unsigned long lastMs = 0;
unsigned long ms = millis();

//wifi
const char* ssid = "SK_WiFiGIGA04C6_2.4G";
const char* password = "1803003041";

//sql 연결셋팅부
IPAddress server_addr(13, 209, 100, 19); // IP of the MySQL *server* here
char user[] = "kdh";
char password_[] = "kim";        // MySQL user login password

WiFiClient client;
MySQL_Connection conn(&client);
MySQL_Cursor* cursor;

char INSERT_SQL[] = "INSERT INTO test_arduino.hello_arduino (message) VALUES ('Hello, Arduino!')"; //샘플쿼리;
char UPDATE_SQL[] = "INSERT INTO test_arduino.hello_arduino (message) VALUES ('Hello, Arduino!')"; //샘플쿼리;

char Time_now[] = "0000-00-00 00:00:00"; //datetime 형태

void setup() {

  Serial.begin(115200); //전송속도

  Wifi_connect(); //와이파이 연결

  setupDateTime();//시간설정

  Serial.print("Connecting to SQL...  ");
  if (conn.connect(server_addr, 3306, user, password_)) {
    Serial.println("OK.");
  }
  else {
    Serial.println("FAILED.");
  }
  // create MySQL cursor object
  cursor = new MySQL_Cursor(&conn);

}

void loop() {
  //시간접근할수 있게
  DateTimeParts p = DateTime.getParts();

  if (WiFi.status() != WL_CONNECTED) { //와이파이 연결이 이상할시에 재접속 하는 코드
    Serial.println("try reconnect");
    Wifi_connect();
  }
  if (p.getMinutes() % 1 == 0) { //매 5분 마다

    sprintf(Time_now, "%04d-%02d-%02d %02d:%02d:00", p.getYear(),
            p.getMonth() + 1, p.getMonthDay(), p.getHours(), p.getMinutes());

    Serial.printf("%s", Time_now); //시간 확인

    sprintf(INSERT_SQL, "INSERT INTO db.Env (`datetime`, `store_id`,`int_temp`) VALUES ('%s',11,12)",Time_now); //쿼리문 온습도 //여기에서 쿼리문을 바꿔주는데..
    if (conn.connected()) {
      cursor->execute(INSERT_SQL);
      sprintf(UPDATE_SQL, "UPDATE db.Env SET `int_temp` = 99 WHERE (`datetime` = '%s')", Time_now);
      cursor->execute(UPDATE_SQL);
    }
  }
  delay(60000);

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
