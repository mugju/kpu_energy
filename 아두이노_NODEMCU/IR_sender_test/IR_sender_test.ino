#include <IRremote.h>
 
//#define POWER 0xFFA25D; 
//#define VOLUMEDOWN 0x40BF728D // 모니터 볼륨 다운
 
IRsend irsend;
 
void setup() {
    Serial.begin(115200);
}
 
void loop() {
    irsend.sendSAMSUNG(0xFFA25D, 32);
    Serial.println("Volume UP");
    delay(3000);
    irsend.sendRC5(0xFFA25D, 32);
    //irsend.sendRC6(0xFFA25D, 32);
    irsend.sendNEC(0xFFA25D, 32);
    //irsend.sendSony(0xFFA25D, 32);
    //irsend.sendPanasonic(0xFFA25D, 32);
    irsend.sendSAMSUNG(0xFFA25D, 32);
    //irsend.sendWhynter(0xFFA25D, 32);
    //sendAiwaRCT501(int code)
    irsend.sendLG(0xFFA25D, 32);
    irsend.sendDISH(0xFFA25D, 32);
    //irsend.sendSharpRaw(0xFFA25D, 32);
    irsend.sendSharp(0xFFA25D, 32);
    //irsend.sendDenon(0xFFA25D, 32);
    //sendPronto(char* code, bool repeat, bool fallback);


    delay(3000);
}

//FF6897
//FFE01F
