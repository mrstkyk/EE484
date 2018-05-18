#line 1 "C:/Users/infcomp1/Desktop/MPU6050/tmp.c"
#line 135 "C:/Users/infcomp1/Desktop/MPU6050/tmp.c"
sbit Soft_I2C_Scl_Output at GPIOB_ODR.B6;
sbit Soft_I2C_Scl_Input at GPIOB_IDR.B6;
sbit Soft_I2C_Sda_Output at GPIOB_ODR.B7;
sbit Soft_I2C_Sda_Input at GPIOB_IDR.B7;






typedef struct
{
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;
 }Accel;
 signed int Temperature;
 struct
 {
 signed int X;
 signed int Y;
 signed int Z;
 }Gyro;
}MPU6050;

void MPU6050_Init()
{
 short err;
  Soft_I2C_Init ();
  Soft_I2C_Start ();
 err= Soft_I2C_Write (  0xD2  );
 err= Soft_I2C_Write (  0x6B  );
 err= Soft_I2C_Write ( 2 );
 err= Soft_I2C_Write ( 0 );
  Soft_I2C_Stop ();
  Soft_I2C_Start ();
 err= Soft_I2C_Write (  0xD2  );
 err= Soft_I2C_Write (  0x1B  );
 err= Soft_I2C_Write ( 0 );
 err= Soft_I2C_Write ( 0 );
  Soft_I2C_Stop ();

 delay_ms(1000);
}
void MPU6050_Read( MPU6050 *Sensor )
{
  Soft_I2C_Start ();
  Soft_I2C_Write (  0xD2  );
  Soft_I2C_Write (  0x3B  );
  Soft_I2C_Start ();
  Soft_I2C_Write (  0xD2  | 1 );
 Sensor->Accel.X = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Accel.Y = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Accel.Z = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Temperature = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Gyro.X = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Gyro.Y = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (1);
 Sensor->Gyro.Z = (  Soft_I2C_Read (1) << 8 ) |  Soft_I2C_Read (0);
  Soft_I2C_Stop ();
 Sensor->Temperature += 12421;
 Sensor->Temperature /= 340;
 UART1_write_text("asd");
}

MPU6050 Sensor;


void main(){


MPU6050_Init();
UART1_Init(9600);



delay_ms(100);



while(1){

 MPU6050_Read( &Sensor );

 UART1_Write(Sensor.Gyro.X);
 delay_ms(100);
 UART1_Write(Sensor.Gyro.Y);
 delay_ms(100);
 UART1_Write(Sensor.Gyro.Z);
 delay_ms(100);


 }

}
