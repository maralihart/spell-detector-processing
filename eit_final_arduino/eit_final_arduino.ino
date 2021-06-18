#include "ICM_20948.h"
ICM_20948_I2C myICM;

void setup() {
 Serial.begin(115200);
 Wire.begin();
 Wire.setClock(400000);
 myICM.begin(Wire, 1);
}

void loop() {
 // Getting IMU data
 if ( myICM.dataReady() ) {
   myICM.getAGMT();
   float ax = myICM.gyrZ();
   float ay = myICM.gyrY();
   int force = analogRead(0);

   Serial.print(ax, 1);
   Serial.print(", ");
   Serial.print(ay, 1);
   Serial.print(", ");
   Serial.print(force);
   Serial.println();
 }
 delay(20);
}
