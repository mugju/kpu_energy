//이 코듸의 경우 달을 표시하는거에서 처음시작이 1월이 아닌 0월로 나와 수정

//21-05-08 기준 코드 변경예정....
// 11센서를 22센서로 변경.. 이후 adafruit코드 실행할거임.. 일단 피드랑 연결을 시켜야 함.

//DHT센서 오류로 그냥 빼버리기로 함 이 센서는 허브에 추가할예정 일단은 11끼워놓기


//MQTT 서버와 연동하기로 함. 소스코드 수정

//mysql 연결관련 헤더
#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>

#include <ESP8266WiFi.h> //와이파이
#include <stdio.h>

//시간 관련 헤더
#include <DateTime.h>
#include <ESPDateTime.h>
#include <TimeElapsed.h>

//MQTT관련 코드
#include <PubSubClient.h>
//char ssid[] = "DongD";           // your network SSID (name)
//char pass[] = "qazwsxedc";           // your network password
const char* mqtt_server = "elijah.iptime.org"; // your MQTT broker,  MQTT브로커 기기가 연결된 IP주소, 숫자사이가 마침표 임 (쉼표아님)
WiFiClient esp8266Client;
PubSubClient client(esp8266Client);

char msg[50];

unsigned long lastMs = 0;
unsigned long ms = millis();

//전류측정
float getVPP();
const int sensorIn = A0;
int mVperAmp = 66; // use 185 for 5A Module and 100 for 20A Module

double Voltage = 0;
double VRMS = 0;
double AmpsRMS = 0;

//wifi
const char* ssid = "DongD";
const char* password = "qazwsxedc";


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

//반복을 피하기 위한 변수
int now_min = 99;

#include <typeinfo>

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

  //릴레이 관련 추가
  pinMode(D5, OUTPUT);
  digitalWrite (D5, HIGH); //릴레이를 켜

  //mqtt서버 연결
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  delay(500);
  client.subscribe("Smplug1");  //MQTT 토픽

}

void loop() {
  if (!client.connected()) { //중간에 연결끊어지면 재시도
    reconnect();
    client.subscribe("Smplug1");
    delay(500);
  }
  client.loop();

  // 계속 전류 측정 해야함.
  Voltage = getVPP();
  VRMS = (Voltage / 2.0) * 0.707;          // RMS값 70.7%
  AmpsRMS = (VRMS * 1000) / mVperAmp;      // mA 단위 맞춰줌
  Serial.print(AmpsRMS);
  Serial.println(" Amps RMS");
  //와트 계산 = 전류 * 220
 
  snprintf (msg, 75, "%d", int(AmpsRMS * 220));
  Serial.print("Publish message: ");
  Serial.println(msg);
  client.publish("Smplug1_elec", msg);

//  Serial.print("누적전력사용량 : ");
//  Serial.println(total_power);             // Irms

  DateTimeParts p = DateTime.getParts(); //시간 받아옴
  if (now_min != p.getMinutes()) {
    if (p.getMinutes() % 5 == 0) { //여기가 5분단위 시점 5분마다 0초에

      now_min = p.getMinutes(); //현재의 분을 다시 넣어 중복을 방지함.

      sprintf(Time_now, "%04d-%02d-%02d %02d:%02d:00", p.getYear(),
              p.getMonth() + 1, p.getMonthDay(), p.getHours(), p.getMinutes()); //datetime형태로 저장

      Serial.printf("%s", Time_now); //저장된 시간 확인 00초

      sprintf(INSERT_SQL, "INSERT INTO db.Env (`datetime`,`store_id`) VALUES ('%s',11)", Time_now); //시간만 일단 넣자. 오류가 뜨면 있는거니까 상관없고 안들어가있으면 데이터 들어갈공간 만들어주는거니까
      if (conn.connected()) {
        cursor->execute(INSERT_SQL); //쿼리 돌렸어요~
      }


      //여기는 스마트플러그로 넘겨줘야함
      sprintf(INSERT_SQL, "INSERT INTO db.Smart_plug VALUES (111,'%s',11,%f)", Time_now, AmpsRMS); //쿼리문 온습도 //111은 제품값인데 여기선 컴퓨터라고 정함
      if (conn.connected()) {
        cursor->execute(INSERT_SQL);
      }


    }//여기가 5분마다 실행되는 부분.

  }
}
float getVPP()
{
  float result;
  int readValue;             //value read from the sensor
  int maxValue = 0;          // store max value here
  int minValue = 1024;          // store min value here

  uint32_t start_time = millis();
  while ((millis() - start_time) < 1000) // 1초동안 값을 모아서 AC 전류의 최고점, 최저점을 찾아 평균치를 구함// 왓다리 갔다리 하거든
  {
    readValue = analogRead(sensorIn);
    // see if you have a new maxValue
    if (readValue > maxValue)
    {
      /*record the maximum sensor value*/
      maxValue = readValue;
    }
    if (readValue < minValue)
    {
      /*record the maximum sensor value*/
      minValue = readValue;
    }
  }

  // Subtract min from max
  result = ((maxValue - minValue) * 5.0) / 1024.0;      // 5V 분해능, 아날로그핀의 분해능 1024

  return result;
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
  DateTime.setTimeZone("UTC-9");
  //DateTime.setServer("asia.pool.ntp.org");
  DateTime.begin(15 * 1000);
  //DateTime.setTimeZone(9);
  DateTime.begin();
  if (!DateTime.isTimeValid()) {
    Serial.println("Failed to get time from server.");
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
    digitalWrite(D5,HIGH);
  }
  if (Message == "0" ) { //MQTT 토픽 Switch1에 0이 수신되면 릴레이응 끔
    client.publish("Test_status", "received TURN OFF");
    // your codes for turn off relay
    Serial.println("스위치 Off");
    digitalWrite(D5,LOW);
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
