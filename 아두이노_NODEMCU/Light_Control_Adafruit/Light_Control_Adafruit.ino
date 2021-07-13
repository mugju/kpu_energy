#include "AdafruitIO_WiFi.h"
#include <Adafruit_NeoPixel.h>

// WiFI & adafruit_IO
#define WIFI_SSID "..."
#define WIFI_PASS "..."
#define IO_USERNAME "whfwkr16"
#define IO_KEY "..."

AdafruitIO_WiFi io(IO_USERNAME, IO_KEY, WIFI_SSID, WIFI_PASS);
AdafruitIO_Feed *feed = io.feed("people", IO_USERNAME);

// LED Pixel
#define PERM_LED_PIN D2
#define LED_PIN D4
#define LED_COUNT  10
#define BRIGHTNESS_LOW 10
#define BRIGHTNESS_HIGH 60
Adafruit_NeoPixel permStrip(LED_COUNT, PERM_LED_PIN, NEO_GRBW + NEO_KHZ800);
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRBW + NEO_KHZ800);


void setup() {
  Serial.begin(115200);
  
  //initialize strip
  strip.begin();
  permStrip.begin();
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
  if(people != 0) strip.setBrightness(BRIGHTNESS_HIGH);
  else strip.setBrightness(BRIGHTNESS_LOW); 
  strip.show();
}

void initializeStrip(){
  strip.setBrightness(BRIGHTNESS_HIGH);  
  permStrip.setBrightness(BRIGHTNESS_HIGH);
  Serial.println("permStrip"); 
  for(int i=0; i<strip.numPixels(); i++) { // For each pixel in strip...
      strip.setPixelColor(i,255,255,255); 
      permStrip.setPixelColor(i,255,255,255); 
  }
  strip.show();
  permStrip.show();
}

