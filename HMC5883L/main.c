/*
  @
  @   Date               :        21.03.2018 / Wednesday
  @                               This code was written while listening:  Geeflow - Araf Sahili    @https://www.youtube.com/watch?v=ZO0QXIojG1Q
  @
  @   Contact            :        Editing by Muhammet Rasit KIYAK                                  @https://www.linkedin.com/in/mrstkyk/
  @                                      mrstkyk@gmail.com
  @
  @   Description        :        This Library for HMC5883 Magnetometer and using Software I2C at 20kHz.
  @                               MCU Clock Frequency 168 MHz  for STM32F407VG Dev.Board
  @
*/

#include "HMC5883L.c"

/*
Software I2C Connection pins
*/
sbit Soft_I2C_Scl_Output    at GPIOD_ODR.B3;
sbit Soft_I2C_Scl_Input     at GPIOD_IDR.B3;
sbit Soft_I2C_Sda_Output    at GPIOD_ODR.B4;
sbit Soft_I2C_Sda_Input     at GPIOD_IDR.B4;

// Magnetometer_Output Magnet;
       int X_out;
       int Y_out;
       int Z_out;
       signed long h;
       unsigned char value=0;

void main() {

//HMC5883L_I2C_Init();
HMC5883L_Init();
 while(1)
     {
     h = HMC5883L_heading();

         delay_ms(100);
     };

}