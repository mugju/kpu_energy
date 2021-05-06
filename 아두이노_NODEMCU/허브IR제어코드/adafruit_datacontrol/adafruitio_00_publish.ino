#define IO_USERNAME "whfwkr16"
#define IO_KEY "aio_BMNE70N5lnnwSuRNjfIdt4kVOcsz"



#define WIFI_SSID "SK_WiFiGIGA04C6_2.4G"
#define WIFI_PASS "1803003041"


#include "AdafruitIO_WiFi.h"

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
//#include "config.h"
#include <typeinfo>
/************************ Example Starts Here *******************************/

// this int will hold the current count for our sketch
int count = 0;

// set up the 'counter' feed
AdafruitIO_Feed *counter = io.feed("counter");

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

}

void loop() {

  // io.run(); is required for all sketches.
  // it should always be present at the top of your loop
  // function. it keeps the client connected to
  // io.adafruit.com, and processes any incoming data.
  io.run();

  // save count to the 'counter' feed on Adafruit IO
  //Serial.print("sending -> ");
  //Serial.println(count);
  //counter->save(1000);
  Serial.println(io.statusText());

  counter->onMessage(handleMessage);
  // increment the count by 1
  //count++;

  // Adafruit IO is rate limited for publishing, so a delay is required in
  // between feed->save events. In this example, we will wait three seconds
  // (1000 milliseconds == 1 second) during each loop.

  delay(5000);

}

//등록되어있는 피드의 값을 받아옴
void handleMessage(AdafruitIO_Data *data) {

  //Serial.print("received <- ");
  Serial.println(data->value());
  Serial.println();
  Serial.println(data->value());
  int state = data->toInt();
  if(state == 1){Serial.println("sdsgdwdgs");}
//  if ((char*)data->value() == "1") {
//    Serial.println("sdsdsds");
//  }
}
