#line 1 "F:/Workspace/Projeler/IHA/MPU6050/STM32F407_MikroC/main.c"
#line 1 "f:/workspace/projeler/iha/mpu6050/stm32f407_mikroc/mpu6050_i2c1.c"
#line 1 "f:/workspace/projeler/iha/mpu6050/stm32f407_mikroc/mpu6050_i2c1.h"
#line 119 "f:/workspace/projeler/iha/mpu6050/stm32f407_mikroc/mpu6050_i2c1.h"
typedef struct
{
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;
 }Accel;
 signed int Temperatura;
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;
 }Gyro;
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;


 }GyroAngle;
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;


 }AccelAngle;
}MPU6050;
#line 1 "f:/portable programs/mikroelektronika/mikroc pro for arm/include/math.h"





double fabs(double d);
double floor(double x);
double ceil(double x);
double frexp(double value, int * eptr);
double ldexp(double value, int newexp);
double modf(double val, double * iptr);
double sqrt(double x);
double atan(double f);
double asin(double x);
double acos(double x);
double atan2(double y,double x);
double sin(double f);
double cos(double f);
double tan(double x);
double exp(double x);
double log(double x);
double log10(double x);
double pow(double x, double y);
double sinh(double x);
double cosh(double x);
double tanh(double x);
#line 4 "f:/workspace/projeler/iha/mpu6050/stm32f407_mikroc/mpu6050_i2c1.c"
void MPU6050_Init()
{
 short err;
  Soft_I2C_Init ();
  Soft_I2C_Start ();
 err= Soft_I2C_Write (  0xD0  );
 err= Soft_I2C_Write (  0x6B  );
 err= Soft_I2C_Write ( 2 );
 err= Soft_I2C_Write ( 0 );
  Soft_I2C_Stop ();
  Soft_I2C_Start ();
 err= Soft_I2C_Write (  0xD0  );
 err= Soft_I2C_Write (  0x1B  );
 err= Soft_I2C_Write ( 0 );
 err= Soft_I2C_Write ( 0 );
  Soft_I2C_Stop ();

 delay_ms(100);
}
void MPU6050_Read( MPU6050 *Sensor )
{
static int gyrox,gyroy,gyroz,accelx,accely,accelz,counter,i=1;
static double gyroScale=131;
static float arx,ary,arz,grx,gry,grz,gsx,gsy,gsz,gx,gy,gz;


static double timeStep, time, timePrev;

 gsx = gx/gyroScale; gsy = gy/gyroScale; gsz = gz/gyroScale;


 timePrev = time;
 time = counter;
 counter=counter+1;
 timeStep = (time - timePrev) / 1000;

  Soft_I2C_Start ();
  Soft_I2C_Write (  0xD0  );
  Soft_I2C_Write (  0x3B  );
  Soft_I2C_Start ();
  Soft_I2C_Write (  0xD0  | 1 );

 Sensor->Accel.X = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);

 accelx=Sensor->Accel.X;

 Sensor->Accel.Y = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 accely=Sensor->Accel.Y;


 Sensor->Accel.Z = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 accelz=Sensor->Accel.Z;
#line 62 "f:/workspace/projeler/iha/mpu6050/stm32f407_mikroc/mpu6050_i2c1.c"
 arx = (57.29579) * atan(accelx / sqrt(pow(accely, 2) + pow(accelz, 2)));
 ary = (57.29579) * atan(accely / sqrt(pow(accelx, 2) + pow(accelz, 2)));
 arz = (57.29579) * atan(sqrt(pow(accely,2) + pow(accelx,2)) / accelz);

 Sensor->AccelAngle.X=arx;
 Sensor->AccelAngle.Y=ary;
 Sensor->AccelAngle.Z=arz;


 Sensor->Temperatura = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Gyro.X = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 gyrox= Sensor->Gyro.X;

 Sensor->Gyro.Y = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 gyroy= Sensor->Gyro.Y;

 Sensor->Gyro.Z = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (0);
 gyroz=Sensor->Gyro.Z;
#line 86 "f:/workspace/projeler/iha/mpu6050/stm32f407_mikroc/mpu6050_i2c1.c"
 if (i == 1) {
 grx = arx;
 gry = ary;
 grz = arz;
 i=i+1;
 }

 else{
 grx = grx + (timeStep * gsx);
 gry = gry + (timeStep * gsy);
 grz = grz + (timeStep * gsz);
 i=i+1;
 }
 grx=Sensor->GyroAngle.X;
 gry=Sensor->GyroAngle.Y;
 grz=Sensor->GyroAngle.Z;

  Soft_I2C_Stop ();

 Sensor->Temperatura += 12421;
 Sensor->Temperatura /= 340;

}
#line 4 "F:/Workspace/Projeler/IHA/MPU6050/STM32F407_MikroC/main.c"
sbit Soft_I2C_Scl_Output at GPIOD_ODR.B3;
sbit Soft_I2C_Scl_Input at GPIOD_IDR.B3;
sbit Soft_I2C_Sda_Output at GPIOD_ODR.B4;
sbit Soft_I2C_Sda_Input at GPIOD_IDR.B4;


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
