#include "MPU6050_I2C1.c"

 // Software I2C connections
sbit Soft_I2C_Scl_Output    at GPIOD_ODR.B3;
sbit Soft_I2C_Scl_Input     at GPIOD_IDR.B3;
sbit Soft_I2C_Sda_Output    at GPIOD_ODR.B4;
sbit Soft_I2C_Sda_Input     at GPIOD_IDR.B4;

// End Software I2C connections
             signed int xg,xangle;
MPU6050 Sensor;

void main() {


    MPU6050_Init();


while(1){
          MPU6050_Read( &Sensor );

           xg=Sensor.Accel.X;
           xangle=Sensor.AccelAngle.X;

           

                              }
}