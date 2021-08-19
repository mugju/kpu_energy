#include <ESP8266WiFi.h>
#include <PubSubClient.h>
char ssid[] = "DongD";           // your network SSID (name)
char pass[] = "qazwsxedc";           // your network password
const char* mqtt_server = "elijah.iptime.org"; // your MQTT broker,  MQTT브로커 기기가 연결된 IP주소, 숫자사이가 마침표 임 (쉼표아님)
WiFiClient esp8266Client;
PubSubClient client(esp8266Client);

char msg[50];
int value = 0;


//내꺼
#define WIFI_SSID "DongD"
#define WIFI_PASS "qazwsxedc" //이거 바꿔


#include "EmonLib.h"
// Include Emon Library
EnergyMonitor emon1;
// Create an instance


double total_power = 0; //누적전력
double power = 0;

#include <ESP8266WiFi.h> //와이파이
//mysql 연결관련 헤더
#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>

//시간 관련 헤더
#include <DateTime.h>
#include <ESPDateTime.h>
#include <TimeElapsed.h>

//sql 연결셋팅부
IPAddress server_addr(13, 209, 100, 19); // IP of the MySQL *server* here
char hostname[] = "database-1.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com";
char user[] = "kdh";
char password_[] = "kim";        // MySQL user login password


MySQL_Connection conn(&esp8266Client);
MySQL_Cursor* cursor;

char INSERT_SQL[] = "INSERT INTO test_arduino.hello_arduino (message) VALUES ('Hello, Arduino!')"; //샘플쿼리;
char UPDATE_SQL[] = "INSERT INTO test_arduino.hello_arduino (message) VALUES ('Hello, Arduino!')"; //샘플쿼리;
char Time_now[] = "0000-00-00 00:00:00"; //datetime 형태

//반복을 피하기 위한 변수
int now_min = 99;


void Wifi_connect() {

  Serial.println("---------------------------------------");
  Serial.println(WIFI_SSID);
  WiFi.begin(WIFI_SSID, WIFI_PASS); // 와이파이 이름과 비밀번호를 통해 WIFI연결을 시작 // WL_CONNECTED라는 값을 돌려준다
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

void setup()
{
  Serial.begin(115200);

  //sql관련
  Wifi_connect(); //와이파이 연결


  emon1.current(A0, 50);             // Current: input pin, calibration.

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

  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  delay(500);
  client.subscribe("Test");  //MQTT 토픽
}

void loop()
{
  if (!client.connected()) {
    reconnect();
    client.subscribe("Test");
    delay(500);
  }
  client.loop();
  double Irms = emon1.calcIrms(1480);  // Calculate Irms only

  Serial.print("사용전력 : ");
  Serial.println(Irms * 220.0);         // Apparent power
  power = Irms * 220.0;
  Serial.print("현재 전류 : ");
  Serial.println(Irms);             // Irms

  total_power += power * 1 / 36000;
  delay(1000); //adafruit에는 2초에 하나 보내야 스로틀이 안걸림 따라서 이 코드 두번 조져야 함.

  Irms = emon1.calcIrms(1480);  // Calculate Irms only
  Serial.print("사용전력 : ");
  Serial.println(Irms * 230.0);         // Apparent power
  power = Irms * 230.0;
  Serial.print("현재 전류 : ");
  Serial.println(Irms);             // Irms

  total_power += power * 1 / 36000;

  delay(1000);

  snprintf (msg, 75, "%d", int(power));
  Serial.print("Publish message: ");
  Serial.println(msg);
  client.publish("SCT013", msg);

  Serial.print("누적전력사용량 : ");
  Serial.println(total_power);             // Irms
  //

  //5분마다 누적전력을 박아줄꺼야 단위는 kW
  DateTimeParts p = DateTime.getParts();


  if (now_min != p.getMinutes()) {
    if (p.getMinutes() % 5 == 0) { //여기가 5분단위 시점 5분마다 0초에

      now_min = p.getMinutes(); //현재의 분을 다시 넣어
      Serial.println(now_min);

      //Serial.println(DateTime.toString()); //5분단위 시간 확인
      sprintf(Time_now, "%04d-%02d-%02d %02d:%02d:00", p.getYear(),
              p.getMonth() + 1, p.getMonthDay(), p.getHours(), p.getMinutes()); //datetime형태로 저장

      Serial.printf("%s", Time_now); //저장된 시간 확인 00초

      sprintf(INSERT_SQL, "INSERT INTO db.Hub (datetime,store_id,amp) VALUES ('%s',11,%f)", Time_now , total_power); //시간만 일단 넣자. 오류가 뜨면 있는거니까 상관없고 안들어가있으면 데이터 들어갈공간 만들어주는거니까
      Serial.println(INSERT_SQL);

      snprintf (msg, 75, "%d", int(total_power));
      Serial.print("Publish message: ");
      Serial.println(msg);
      client.publish("Total_power", msg);
      total_power = 0;
      if (conn.connected()) {
        Serial.println("query go");
        cursor->execute(INSERT_SQL); //쿼리 돌렸어요~
      }


    }
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  String Message = "";
  int i = 0;
  while (i < length) Message += (char)payload [i++];
  Serial.println (Message);

  if (Message == "1" ) { //MQTT 토픽 Switch1에 1이 수신되면 릴레이를 켬
    client.publish("Test_status", "received TURN ON");
    // your codes for turn on relay
    Serial.println("스위치 On");
    //digitalWrite(15,HIGH);
  }
  if (Message == "0" ) { //MQTT 토픽 Switch1에 0이 수신되면 릴레이응 끔
    client.publish("Test_status", "received TURN OFF");
    // your codes for turn off relay
    Serial.println("스위치 Off");
    //digitalWrite(15,LOW);
  }
}

void reconnect() {
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    Wifi_connect();
  }
  while (!client.connected()) {
    Serial.println("Attempting MQTT connection...");
    if (client.connect("arduinoClientRelay")) {     //MQTT client name 고유한 이름으로 중복되지 않도록 주의
      Serial.println("connected");
    }
    else {
      Serial.print("MQTT connection failed, retry count: ");
      Serial.println(client.state());
      Serial.println("try again in 3 seconds");
      delay(3000);
    }
  }
}



void setupDateTime() {
  // 와이파이 연결이후에 수정하세요
  // you can use custom timeZone,server and timeout
  DateTime.setTimeZone("UTC-9");
  //DateTime.setServer("asia.pool.ntp.org");
  DateTime.begin(15 * 1000);
  //DateTime.setTimeZone(9);
  DateTime.begin();
  if (!DateTime.isTimeValid()) {
    Serial.println("Failed to get time from server.");
  }
}
