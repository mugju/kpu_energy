//
//#include "EmonLib.h"                   // Include Emon Library
//EnergyMonitor emon1;                   // Create an instance
//
//double IrmsNock = 0;
//double total_power = 0;
//unsigned long t1= 0;
//void setup()
//{  
//  Serial.begin(115200);
//         //아날로그핀번호, 상수값
//         //SCT013-050 = 50
//  emon1.current(A0, 50);             // Current: input pin, calibration.
//
//  //5개 샘플정도를 얻은다음에 그값을 아래쪽에서 빼버리자!
//  for(int i = 0;i<5;i++){
//    IrmsNock += emon1.calcIrms(1480);
//  }
//  IrmsNock = IrmsNock / 5; //IrmsNock /= 5
//
//  Serial.println(IrmsNock);
//
//  t1 = millis();
//}
//
//void loop()
//{
//  double Irms = emon1.calcIrms(1480)-IrmsNock;  // Calculate Irms only
//  if(Irms < 0) Irms = 0;
//
//  unsigned int t2 = millis();
//  int nocktime = t2 - t1;
//  t1 = t2;
//  double power = Irms*220.0;
//  //noctime = 1/1000 s
//  //total_power는 시간(h)가 곱해져야하는데
//  //현재 측정된 nocktime의 경우에는 ms단위이다.
//  //그러므로 ms를 s로 바꾸기위해서 1000을 나눠줘야하고,
//  //s를 m으로 바꾸기위해서 60을 나눠줘야하고, m을 h로 바꾸기위해서 60을 나눠줘야한다.
//  //그렇지만 전체 360만이라는 값을 한번에 나누면 double자료형의 소수점 유효숫자에 범위가 줄어들기 때문에
//  //우선적으로 3600을 나누고 최종결과에서 1000을 나누도록 한다!
//  total_power += power * nocktime/3600; 
//  Serial.print(nocktime); //샘플간격의 시간
//  Serial.print(" ");
//  Serial.print(total_power/1000,4); //누적전력량
//  Serial.print(" ");
//  Serial.print(power,4); //순간전력
//  Serial.print(" ");
//  Serial.println(Irms,4); //순간전류
//}



#include "EmonLib.h"
// Include Emon Library
EnergyMonitor emon1;
// Create an instance
void setup()
{
  Serial.begin(115200);

  emon1.current(A0, 50);             // Current: input pin, calibration.
}

void loop()
{
  double Irms = emon1.calcIrms(1480);  // Calculate Irms only
  Serial.print(Irms*230.0);           // Apparent power
  Serial.print(" ");
  Serial.println(Irms);             // Irms
}
