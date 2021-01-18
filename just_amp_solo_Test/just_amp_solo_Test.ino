const int analogIn = A0; //아날로그 입력 PIN
int mVperAmp = 66; // 아날로그 입력 mV당 전류 값
// 5A 짜리는 185
// 20A 짜리는 100
// 30A 짜리는 66
int RawValue = 0;  // 아날로그 값 저장 변수
int ACSoffset = 2728; // 기준 값 0A일때 아날로그 값은 2500mV 이다.
double Voltage = 0;   // 계산된 아날로그 값
double Amps = 0;      // 실제 측정된 전류 값

void setup() {
  Serial.begin(115200);
}

void loop() {

  RawValue = analogRead(analogIn);
  Voltage = (RawValue / 1024.0) * 5000;
  Amps = ((Voltage - ACSoffset) / mVperAmp);

  Serial.print(Voltage / 1000);
  Serial.print("\t");
  Serial.println(Amps);
  delay(100);
}
