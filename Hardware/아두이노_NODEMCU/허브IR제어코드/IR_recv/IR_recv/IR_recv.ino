#include <IRremote.h>
 
#define IRRECV_PIN 2 // IR 수신 핀 할당
 
// IR 수신 클래스 객체 생성
IRrecv irrecv(IRRECV_PIN);
// IR 수신하여 복조된 데이터 클래서 객체 생성(수신된 데이터의 저장소)
decode_results results;
// decodeType 출력을 편하게 하기위한 문자열 배열
String decodeType[19] = {
                          "UNKNOWN", // decodeType : -1
                          "UNUSED", // decodeType : 0
                          "RC5",
                          "RC6",
                          "NEC",
                          "SONY",
                          "PANASONIC",
                          "JVC",
                          "SAMSUNG",
                          "WHYNTER",
                          "AIWA_RC_T501",
                          "LG",
                          "SANYO",
                          "MITSUBISHI",
                          "DISH",
                          "SHARP",
                          "DENON",
                          "PRONTO",
                          "LEGO_PF",
                      };
 
void setup()
{
    Serial.begin(9600);
    delay(3000);
    Serial.println(F("IR Recv Program Start..."));
    irrecv.enableIRIn(); // IR 리시버 동작 시작
    //irrecv.blink13(true);
}
 
void loop() {
    // irrecv.decode(&results) 수신된 IR 데이터 처리가 문제 없는 경우 1(TRUE)을 반환
    if (irrecv.decode(&results)) {
        // DecodeType, Data, Bit 수를 출력
        Serial.println(F("========================================"));
        Serial.print(F("Decode Type        : "));
        Serial.println(decodeType[results.decode_type+1]);
        Serial.print(F("Received Data      : 0x"));
        Serial.println(results.value, HEX);
        Serial.print(F("Received Data Bits : "));
        Serial.println(results.bits);
        irrecv.resume(); // 다음신호를 받을 수 있도록 준비
    }
    delay(100);
}
//
//#include <IRremote.h>
//
//int RECV_PIN = 2;
//
//IRrecv irrecv(RECV_PIN);
//
//decode_results results;
//
//void setup()
//{
//  Serial.begin(9600);
//  irrecv.enableIRIn(); // Start the receiver
//  Serial.println("094");
//}
//
//void loop() {
//  if (irrecv.decode(&results)) {
//    Serial.println(results.value, HEX);
//    irrecv.resume(); // Receive the next value
//  }
//}
