#include "MPU6050_I2C1.h"
#include <math.h>

void MPU6050_Init()
{
 short err;
 MPU6050_I2C_Init();
 MPU6050_I2C_Start();
 err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
 err=MPU6050_I2C_Wr( MPU6050_RA_PWR_MGMT_1 );
 err=MPU6050_I2C_Wr( 2 ); //Sleep OFF
 err=MPU6050_I2C_Wr( 0 );
 MPU6050_I2C_Stop();
 MPU6050_I2C_Start();
 err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
 err=MPU6050_I2C_Wr( MPU6050_RA_GYRO_CONFIG );
 err=MPU6050_I2C_Wr( 0 ); //gyro_config, +-250 °/s
 err=MPU6050_I2C_Wr( 0 ); //accel_config +-2g
 MPU6050_I2C_Stop();

 delay_ms(100);
}
void MPU6050_Read( MPU6050 *Sensor ) //creates a pointer(*sensor) to a variable of the MPU6050 type.
{
static int gyrox,gyroy,gyroz,accelx,accely,accelz,counter,i=1;
static double gyroScale=131;
static float arx,ary,arz,grx,gry,grz,gsx,gsy,gsz,gx,gy,gz;


static double timeStep, time, timePrev;

  gsx = gx/gyroScale;   gsy = gy/gyroScale;   gsz = gz/gyroScale;
  
  
 timePrev = time;
  time = counter;
  counter=counter+1;
  timeStep = (time - timePrev) / 1000; // time-step in s

 MPU6050_I2C_Start();
 MPU6050_I2C_Wr( MPU6050_ADDRESS );
 MPU6050_I2C_Wr( MPU6050_RA_ACCEL_XOUT_H );
 MPU6050_I2C_Start();
 MPU6050_I2C_Wr( MPU6050_ADDRESS | 1 );
 
 Sensor->Accel.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1); //the pointer puts de read value on the Accel.X variable (part of MPU6050 struct)
 //Sensor->Accel.X=accelx;
 accelx=Sensor->Accel.X;

 Sensor->Accel.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
  accely=Sensor->Accel.Y;


 Sensor->Accel.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 accelz=Sensor->Accel.Z;


/*
Accelerometer angle

*/
  arx = (57.29579) * atan(accelx / sqrt(pow(accely, 2) + pow(accelz, 2))); //constant coming from 180/3.14
  ary = (57.29579) * atan(accely / sqrt(pow(accelx, 2) + pow(accelz, 2)));
  arz = (57.29579) * atan(sqrt(pow(accely,2) + pow(accelx,2)) / accelz);

  Sensor->AccelAngle.X=arx;
   Sensor->AccelAngle.Y=ary;
   Sensor->AccelAngle.Z=arz;


 Sensor->Temperatura = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 Sensor->Gyro.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
  gyrox= Sensor->Gyro.X;

 Sensor->Gyro.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
   gyroy= Sensor->Gyro.Y;

 Sensor->Gyro.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(0);
  gyroz=Sensor->Gyro.Z;


/*
Gyro angle

*/
  if (i == 1) {
    grx = arx;
    gry = ary;
    grz = arz;
    i=i+1;
  }
  // integrate to find the gyro angle
  else{
    grx = grx + (timeStep * gsx);
    gry = gry + (timeStep * gsy);
    grz = grz + (timeStep * gsz);
    i=i+1;
  }
  grx=Sensor->GyroAngle.X;
  gry=Sensor->GyroAngle.Y;
  grz=Sensor->GyroAngle.Z;

 MPU6050_I2C_Stop();

 Sensor->Temperatura += 12421;
 Sensor->Temperatura /= 340;
 //i=i+1;
}



//inline double to_degrees(double radians) {