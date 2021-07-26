// 자동정렬은 ctrl + T
// 일단 시간 조작해서 넣는것은 성공. 해당 코드 복붙해서 메모장에 보관할것!
//이 코듸의 경우 달을 표시하는거에서 처음시작이 1월이 아닌 0월로 나와 수정

//21-05-08 기준 코드 변경예정....
// 11센서를 22센서로 변경.. 이후 adafruit코드 실행할거임.. 일단 피드랑 연결을 시켜야 함.

//DHT센서 오류로 그냥 빼버리기로 함 이 센서는 허브에 추가할예정 일단은 11끼워놓기

//mysql 연결관련 헤더
#include <MySQL_Connection.h>
#include <MySQL_Cursor.h>

#include <ESP8266WiFi.h> //와이파이
#include <stdio.h>
//걍빼자
////온습도 관련 센서
//#include <DHT.h> //DHT11했던거 22도 동일한지는 모르겠음
//#define DHTPIN D2
//#define DHTTYPE DHT22   //22로 수정함. 다시 11
//DHT dht(DHTPIN, DHTTYPE);

//시간 관련 헤더
#include <DateTime.h>
#include <ESPDateTime.h>
#include <TimeElapsed.h>







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

//내꺼
//#define WIFI_SSID "DongD"
//#define WIFI_PASS "qazwsxedc" //이거 바꿔
//const char* ssid = "SK_WiFiGIGA04C6_2.4G";
//const char* password = "1803003041";
const char* ssid = "DongD";
const char* password = "qazwsxedc";


//const char* ssid = "AndroidHotspot1283";
//const char* password = "j1234567"; //이거 바꿔

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

///adafruit관련 추가내용
//adafrut관련 값들
#define IO_USERNAME "whfwkr16"
#define IO_KEY "aio_tdQa196PRqRNuFaN4o4g3KHmwagr"

#include "AdafruitIO_WiFi.h"
////////////////////////////////////////////////
#if defined(USE_AIRLIFT) || defined(ADAFRUIT_METRO_M4_AIRLIFT_LITE) ||         \
    defined(ADAFRUIT_PYPORTAL)
// Configure the pins used for the ESP32 connection
#if !defined(SPIWIFI_SS) // if the wifi definition isnt in the board variant
// Don't change the names of these #define's! they match the variant ones
#define SPIWIFI SPI
#define SPIWIFI_SS 10 // Chip select pin
#define NINA_ACK 9    // a.k.a BUSY or READY pin
#define NINA_RESETN 6 // Reset pin
#define NINA_GPIO0 -1 // Not connected
#endif
AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, ssid, password, SPIWIFI_SS,
                   NINA_ACK, NINA_RESETN, NINA_GPIO0, &SPIWIFI);
#else
AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, ssid, password);
#endif

#include <typeinfo>
/////////////////////////////////////////////
//피드이름

AdafruitIO_Feed *SM_plug = io.feed("SM_plug");

AdafruitIO_Feed *SM_elec = io.feed("SM_elec");

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

  // connect to io.adafruit.com
  io.connect();

  // wait for a connection
  while (io.status() < AIO_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  // we are connected
  Serial.println();
  Serial.println(io.statusText());

}

void loop() {


  if (WiFi.status() != WL_CONNECTED) { //와이파이 연결이 이상할시에 재접속 하는 코드
    Serial.println("try reconnect");
    Wifi_connect();
  }
  io.run();//이건 피드 접속하려면 무적권

  //Serial.println(io.statusText()); //피드 상태메시지 확인

  SM_plug->onMessage(handleMessage); //메시지 수신했음
//  light->onMessage(handleMessage); //메시지 수신했음



  DateTimeParts p = DateTime.getParts();

  if (now_min != p.getMinutes()) {
    if (p.getMinutes() % 5 == 0) { //여기가 5분단위 시점 5분마다 0초에

      now_min = p.getMinutes(); //현재의 분을 다시 넣어

      //Serial.println(DateTime.toString()); //5분단위 시간 확인
      sprintf(Time_now, "%04d-%02d-%02d %02d:%02d:00", p.getYear(),
              p.getMonth() + 1, p.getMonthDay(), p.getHours(), p.getMinutes()); //datetime형태로 저장

      Serial.printf("%s", Time_now); //저장된 시간 확인 00초

      sprintf(INSERT_SQL, "INSERT INTO db.Env (`datetime`,`store_id`) VALUES ('%s',11)", Time_now); //시간만 일단 넣자. 오류가 뜨면 있는거니까 상관없고 안들어가있으면 데이터 들어갈공간 만들어주는거니까
      if (conn.connected()) {
        cursor->execute(INSERT_SQL); //쿼리 돌렸어요~
      }

//      //온습도 저장 (이것도 5분단위로 수집하자)
//      int h = dht.readHumidity();
//      int t = dht.readTemperature();
//
//      Serial.print("humidity:");
//      Serial.println(h);                  // 습도 값 출력
//      Serial.print("temperature:");
//      Serial.println(t);                  // 온도 값 출력



      Voltage = getVPP();
      VRMS = (Voltage / 2.0) * 0.707;          // RMS값 70.7%
      AmpsRMS = (VRMS * 1000) / mVperAmp;      // mA 단위 맞춰줌
      Serial.print(AmpsRMS);
      Serial.println(" Amps RMS");
      SM_elec->save(int(AmpsRMS*220));

      

//      //sprintf(INSERT_SQL, "INSERT INTO test.env VALUES (NOW(),%d,%d)", t, h); //쿼리문 온습도
//      sprintf(UPDATE_SQL, "UPDATE db.Env SET `int_temp` = %d , `int_humid` = %d WHERE (`datetime` = '%s')", t, h, Time_now); //데이터 넣어줄 쿼리 온도와 습도를 넣어줌
//      if (conn.connected()) {
//        cursor->execute(UPDATE_SQL);
//      }

      //여기는 스마트플러그로 넘겨줘야함
      sprintf(INSERT_SQL, "INSERT INTO db.Smart_plug VALUES (111,'%s',11,%f)", Time_now, AmpsRMS); //쿼리문 온습도 //111은 제품값인데 여기선 컴퓨터라고 정함
      if (conn.connected()) {
        cursor->execute(INSERT_SQL);
      }
      //일단 이건 지우고 값 테스트를 진행한 다음 다시 주석을 풀자
      //    delay(299000); //1초마다 반복하되 시간이 자꾸밀려서 이 값은 조정 필요. 원래299000초 즉 5분


    }//여기가 5분마다 실행되는 부분.
    //delay(5000);
  }
  delay(5000);
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


//등록되어있는 피드의 값을 받아옴
void handleMessage(AdafruitIO_Data *data) {

  //Serial.print("received <- ");
  Serial.println(data->value());
  Serial.println();
  Serial.println(data->value());
  int state = data->toInt();
  if (state == 1) {
    Serial.println("Power On");
    digitalWrite (D5, HIGH); //릴레이를 켜
  } //켜졌을때
  if (state == 0) {
    Serial.println("Power OFF");
    digitalWrite (D5, LOW); //릴레이를 꺼

  } //켜졌을때

}
