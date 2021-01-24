#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>
#include <ESP8266WiFi.h> //와이파이
#include <stdio.h>

#include <DHT.h> //DHT11했던거 22도 동일한지는 모르겠음
#define DHTPIN D2
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

//전류측정
float getVPP();
const int sensorIn = A0;
int mVperAmp = 66; // use 185 for 5A Module and 100 for 20A Module

double Voltage = 0;
double VRMS = 0;
double AmpsRMS = 0;

//wifi
const char* ssid = "SK_WiFiGIGA04C6_2.4G";
const char* password = "1803003041";

//sql 연결셋팅부
IPAddress server_addr(13, 209, 100, 19); // IP of the MySQL *server* here
//char hostname[] = "joljag.cshxrgoa1y2b.ap-northeast-2.rds.amazonaws.com"; // change to your server's hostname/URL
char user[] = "root";
char password_[] = "whfwkr16";        // MySQL user login password

WiFiClient client;
MySQL_Connection conn(&client);
MySQL_Cursor* cursor;

char INSERT_SQL[] = "INSERT INTO test_arduino.hello_arduino (message) VALUES ('Hello, Arduino!')";

void setup() {
  Serial.begin(115200); //전송속도

  Serial.println();
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
  int h = dht.readHumidity();
  int t = dht.readTemperature();

  Serial.print("humidity:");
  Serial.println(h);                  // 습도 값 출력
  Serial.print("temperature:");
  Serial.println(t);                  // 온도 값 출력


  sprintf(INSERT_SQL, "INSERT INTO test.env VALUES (NOW(),%d,%d)", t, h); //쿼리문 온습도
  if (conn.connected()) {
    cursor->execute(INSERT_SQL);
  }
  Voltage = getVPP();
  VRMS = (Voltage / 2.0) * 0.707;          // RMS값 70.7%
  AmpsRMS = (VRMS * 1000) / mVperAmp;      // mA 단위 맞춰줌
  Serial.print(AmpsRMS);
  Serial.println(" Amps RMS");

  sprintf(INSERT_SQL, "INSERT INTO test.elec_stat VALUES (NOW(),%f,111)", AmpsRMS); //쿼리문 온습도 //111은 모니터 값
  if (conn.connected()) {
    cursor->execute(INSERT_SQL);
  }

  delay(599000); // 반복해 10분마다
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
