
#include <ESP8266WiFi.h>

#include <IRremote.h>


//이 코드는 esp8266 NODEMCU를 위한 코드이며,
//추가될 기능으로는 IR신호를 전송하는 것과 , adafruit IO를 사용하여 원격으로
//신호를 보내는 것이 최종 목표입니다.  

#define IR_RECEIVE_PIN          14 // D5
#define IR_RECEIVE_PIN_STRING   "D5"
#define IR_SEND_PIN             12 // D6 - D4/pin 2 is internal LED
#define IR_SEND_PIN_STRING      "D6"


#define DELAY_AFTER_SEND 2000
#define DELAY_AFTER_LOOP 5000

/*
 * Set up the data to be sent.
 * For most protocols, the data is build up with a constant 8 (or 16 byte) address
 * and a variable 8 bit command.
 * There are exceptions like Sony and Denon, which have 5 bit address.
 */
uint16_t sAddress = 0xEFF28877;
uint8_t sCommand = 0x40;
uint8_t sRepeats = 0;

void setup() {
    Serial.begin(115200);
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
     * Print internal signal generation info
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
  // put your main code here, to run repeatedly:

    Serial.println(F("Send NEC with 8 bit address"));
    Serial.flush();
    //잘 모르겠는데 옛날 함수가 잘먹어
    IrSender.sendNEC(0xEFF28877,32);
    delay(DELAY_AFTER_SEND); // delay must be greater than 5 ms (RECORD_GAP_MICROS), otherwise the receiver sees it as one long signal
//    //여기랑
//    Serial.println(F("Send NEC with 16 bit address"));
//    Serial.flush();
//    IrSender.sendNEC(sAddress, sCommand, sRepeats);
//    delay(DELAY_AFTER_SEND);
//    Serial.println(F("Send RC5"));
//    Serial.flush();
//    IrSender.sendRC5(sAddress & 0x1F, sCommand & 0x3F, sRepeats, true); // 5 address, 6 command bits
//    delay(DELAY_AFTER_SEND);
//
//    Serial.println(F("Send RC5X with 7.th MSB of command set"));
//    Serial.flush();
//    IrSender.sendRC5(sAddress & 0x1F, (sCommand & 0x3F) + 0x40, sRepeats, true); // 5 address, 7 command bits
//    delay(DELAY_AFTER_SEND);
//
//    Serial.println(F("Send RC6"));
//    Serial.flush();
//    IrSender.sendRC6(sAddress, sCommand, sRepeats, true);
//    delay(DELAY_AFTER_SEND);


//    /*
//     * Next example how to use the IrSender.write function
//     */
//    IRData IRSendData;
//    // prepare data
//    IRSendData.address = sAddress;
//    IRSendData.command = sCommand;
//    IRSendData.flags = IRDATA_FLAGS_EMPTY;
//
//    //여기
//    IRSendData.protocol = NEC;
//    Serial.print(F("Send "));
//    Serial.println(getProtocolString(IRSendData.protocol));
//    IrSender.write(&IRSendData, sRepeats);
//    delay(DELAY_AFTER_SEND);
//    
//    //여기에 집중!!!!!!!!!!!!!!!!
//    IRSendData.protocol = SAMSUNG;
//    Serial.print(F("Send "));
//    Serial.println(getProtocolString(IRSendData.protocol));
//    IrSender.write(&IRSendData, sRepeats);
//    delay(DELAY_AFTER_SEND);
//
//
//
//    IRSendData.protocol = LG;
//    Serial.print(F("Send "));
//    Serial.println(getProtocolString(IRSendData.protocol));
//    Serial.flush();
//    IrSender.write(&IRSendData, sRepeats);
//    delay(DELAY_AFTER_SEND);
//
//    IRSendData.protocol = BOSEWAVE;
//    Serial.println(F("Send Bosewave with no address and 8 command bits"));
//    Serial.flush();
//    IrSender.write(&IRSendData, sRepeats);
//    delay(DELAY_AFTER_SEND);

}
