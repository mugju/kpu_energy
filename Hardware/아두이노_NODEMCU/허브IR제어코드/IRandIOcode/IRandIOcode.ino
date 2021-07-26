//이 코드는 io와 ir제어를 합친 코드로 이는 아직 깃헙에는 업로드 하지 않고 테스트용 코드임
#define IO_USERNAME "whfwkr16"
#define IO_KEY "aio_*********************"


#define WIFI_SSID "SK_WiFiGIGA04C6_2.4G"
#define WIFI_PASS "***********" //이거 바꿔




#include "AdafruitIO_WiFi.h"

//IR관련 헤더
#include <ESP8266WiFi.h>
#include <IRremote.h>

//IR관련 핀맵설정
#define IR_RECEIVE_PIN          14 // D5
#define IR_RECEIVE_PIN_STRING   "D5"
#define IR_SEND_PIN             12 // D6 - D4/pin 2 is internal LED
#define IR_SEND_PIN_STRING      "D6"

#define DELAY_AFTER_SEND 2000
#define DELAY_AFTER_LOOP 5000




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
AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS, SPIWIFI_SS,
                   NINA_ACK, NINA_RESETN, NINA_GPIO0, &SPIWIFI);
#else
AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS);
#endif

#include <typeinfo>

// set up the 'counter' feed
AdafruitIO_Feed *counter = io.feed("counter");
AdafruitIO_Feed *f = io.feed("f"); //듀얼피드 확인용
void setup() {

  // start the serial connection
  Serial.begin(115200);

  // wait for serial monitor to open
  while (! Serial);

  Serial.print("Connecting to Adafruit IO");

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


//여기 핀맵관련인데 지울코드 지우자..
#if defined(__AVR_ATmega32U4__) || defined(SERIAL_USB) || defined(SERIAL_PORT_USBVIRTUAL)  || defined(ARDUINO_attiny3217)
  delay(4000); // To be able to connect Serial monitor after reset or power up and before first print out. Do not wait for an attached Serial Monitor!
#endif
  // Just to know which program is running on my Arduino
  Serial.println(F("START " __FILE__ " from " __DATE__ "\r\nUsing library version " VERSION_IRREMOTE));

  IrSender.begin(IR_SEND_PIN, ENABLE_LED_FEEDBACK); // Specify send pin and enable feedback LED at default feedback LED pin

  Serial.print(F("Ready to send IR signals at pin "));
#if defined(ARDUINO_ARCH_STM32) || defined(ESP8266)
  Serial.println(IR_SEND_PIN_STRING);
#else
  Serial.println(IR_SEND_PIN);
#endif

#if !defined(SEND_PWM_BY_TIMER) && !defined(USE_NO_SEND_PWM) && !defined(ESP32) // for esp32 we use PWM generation by ledcWrite() for each pin
  /*
     Print internal signal generation info
  */
  IrSender.enableIROut(38);

  Serial.print(F("Send signal mark duration is "));
  Serial.print(IrSender.periodOnTimeMicros);
  Serial.print(F(" us, pulse correction is "));
  Serial.print((uint16_t) PULSE_CORRECTION_NANOS);
  Serial.print(F(" ns, total period is "));
  Serial.print(IrSender.periodTimeMicros);
  Serial.println(F(" us"));
#endif




}

void loop() {


  io.run();


  //Serial.println(count);
  //counter->save(1000);
  Serial.println(io.statusText());

  counter->onMessage(handleMessage); //메시지 수신했음

  f->onMessage(handleMessage); //메시지 수신했음 //여기피드도 숫자로 조져야함


  delay(5000);

}

//등록되어있는 피드의 값을 받아옴
void handleMessage(AdafruitIO_Data *data) {

  //Serial.print("received <- ");
  Serial.println(data->value());
  int state = data->toInt();
  if (state == 1) {
    Serial.println("Power On"); //켜졌을때
    Serial.println(F("Send NEC"));
    Serial.flush();
    //잘 모르겠는데 옛날 함수가 잘먹어
    IrSender.sendNEC(0xFFA25D,32);
  }
  if (state == 0) {
    Serial.println("Power OFF"); //켜졌을때
  }

}
