#include "AdafruitIO_WiFi.h"
#include <Adafruit_NeoPixel.h>

// WiFI & adafruit_IO
#define WIFI_SSID "Elijah"
#define WIFI_PASS "elijah0816"
#define IO_USERNAME "whfwkr16"
#define IO_KEY "aio_SAdm97C9x6lR1txMGkd27vy0scsG"

AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS);
AdafruitIO_Feed *feed = io.feed("people", IO_USERNAME);

// LED Pixel
#define LED_PIN D7
#define LED_COUNT  60
#define BRIGHTNESS_LOW 10
#define BRIGHTNESS_HIGH 40
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRBW + NEO_KHZ800);


void setup() {
  Serial.begin(115200);
  
  //initialize strip
  strip.begin();
  initializeStrip();
  
  // Connect to Adafruit IO
  io.connect();
  // wait for a connection
  while(io.status() < AIO_CONNECTED) 
  {
    Serial.println(".");
    delay(500);
  }
  Serial.println(io.statusText());
  Serial.println("Connected");
  feed->get();
}

void loop() {
  io.run();
  feed->onMessage(handleMessage);
}

void handleMessage(AdafruitIO_Data *data) {
  Serial.print("people <-  ");
  int people = data->toInt();
  Serial.println(people);
  stripOn(people);
}

void stripOn(int people){
  if(people == 1) strip.setBrightness(BRIGHTNESS_HIGH);
  else strip.setBrightness(BRIGHTNESS_LOW); 
  strip.show();
}

void initializeStrip(){
  for(int i=0; i<strip.numPixels(); i++) { // For each pixel in strip...
      strip.setBrightness(BRIGHTNESS_HIGH);  
      strip.setPixelColor(i,255,255,255);  
  }
  strip.show();
}

