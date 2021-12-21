#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Adafruit_NeoPixel.h>

// WiFI & adafruit_IO
#define WIFI_SSID "ElijahL"
#define WIFI_PASS "1q2w3e4r"
#define MQTT_SERVER "elijah.iptime.org"



// LED Pixel
#define PERM_LED_PIN D7
#define LED_PIN D8
#define LED_COUNT  10
#define BRIGHTNESS_LOW 10
#define BRIGHTNESS_HIGH 120
Adafruit_NeoPixel permStrip(LED_COUNT, PERM_LED_PIN, NEO_GRBW + NEO_KHZ800);
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRBW + NEO_KHZ800);

WiFiClient espClient;
PubSubClient client(espClient);


long last_send_time = 0; 
char publish_msg[16];

void setup() {
  Serial.begin(115200);
  
  //initialize strip
  strip.begin();
  permStrip.begin();
  initializeStrip();

  //connect to wifi
  setup_wifi();
  client.setServer(MQTT_SERVER, 1883);
  client.setCallback(callback);
  
}

void loop() {
  //mqtt에서 계속 읽어오기
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  // Switch on the LED if 1 was received as first character
  if ((char)payload[0] == '1') {
    stripOn(1);
  } else {
    stripOn(0);
  }

}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect("ESP8266Client")) {
      Serial.println("connected");
      client.subscribe("Smplug1");
      Serial.println("subscribe People");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void setup_wifi() {

  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(WIFI_SSID);
  
  WiFi.begin(WIFI_SSID, WIFI_PASS);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
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

