#line 1 "F:/Workspace/Projeler/IHA/BMP085/pressure_sensor_bmp085.c"
#line 1 "f:/workspace/projeler/iha/bmp085/bmp085.c"
#line 1 "f:/portable programs/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 46 "f:/workspace/projeler/iha/bmp085/bmp085.c"
typedef struct
{
 float Temperatura;
 float Pressao;
 float Altitude;
}BMP085;

typedef struct
{
 int AC1;
 int AC2;
 int AC3;
 unsigned AC4;
 unsigned AC5;
 unsigned AC6;
 int mB1;
 int mB2;
 int MB;
 int MC;
 int MD;
}Calibration_Data;

Calibration_Data Cal;


void BMP085_Init()
{
char i;
  I2C1_Start ();
  I2C1_Wr (  0xEE  );
  I2C1_Wr (  0xAA  );
  I2C1_Start ();
  I2C1_Wr (  0xEE  | 1 );

 for( i=0; i < 10; i++)
 {
 ((int*)&Cal)[i] = ( I2C1_Rd (1) << 8) +  I2C1_Rd (1);

 }
 ((int*)&Cal)[10] = ( I2C1_Rd (1) << 8) +  I2C1_Rd (0);
  I2C1_Stop ();
}

void BMP085_Read( char oversampling, BMP085 *Bar )
{
char cmd = 0x34;
long UT=0, UP=0, _B3, _B5, _B6, X1, X2, X3, pp;
unsigned long _B4, _B7;



  I2C1_Start ();
  I2C1_Wr (  0xEE  );
  I2C1_Wr (  0xF4  );
  I2C1_Wr (  0x2E  );
  I2C1_Stop ();

 Delay_ms( 5 );

  I2C1_Start ();
  I2C1_Wr (  0xEE  );
  I2C1_Wr (  0xF6  );
  I2C1_Start ();
  I2C1_Wr (  0xEE  | 1 );
  ((char *)&UT)[1]  =  I2C1_Rd (1);
  ((char *)&UT)[0]  =  I2C1_Rd (0);
  I2C1_Stop ();


 cmd.B6 = oversampling.B0;
 cmd.B7 = oversampling.B1;
  I2C1_Start ();
  I2C1_Wr (  0xEE  );
  I2C1_Wr (  0xF4  );
  I2C1_Wr ( cmd );
  I2C1_Stop ();

 switch(oversampling)
 {
 case 0: Delay_ms(5); break;
 case 1: Delay_ms(8); break;
 case 2: Delay_ms(14); break;
 case 3: Delay_ms(26); break;
 }



  I2C1_Start ();
  I2C1_Wr (  0xEE  );
  I2C1_Wr (  0xF6  );
  I2C1_Start ();
  I2C1_Wr (  0xEE  | 1 );
  ((char *)&UP)[2]  =  I2C1_Rd (1);
  ((char *)&UP)[1]  =  I2C1_Rd (1);
  ((char *)&UP)[0]  =  I2C1_Rd (0);
  I2C1_Stop ();
  ((char *)&UP)[3]  = 0;
 UP >>= ( 8 - oversampling );


 X1 = ( UT - Cal.AC6 );
 X1 *= Cal.AC5;
 X1 >>= 15;

 X2 = ((long)Cal.MC << 11);
 X2 /= (X1 + Cal.MD);

 _B5 = X1 + X2;

 Bar->Temperatura = ( (_B5 + 8) >> 4 ) / 10;


 _B6 = _B5 - 4000;

 X1 = pow(_B6, 2);
 X1 >>= 12;
 X1 *= (long)Cal.mB2;
 X1 >>= 11;

 X2 = ((long)Cal.AC2 * _B6);
 X2 >>= 11;

 X3 = X1 + X2;

 _B3 = (long)Cal.AC1 * 4;
 _B3 += X3;
 _B3 <<= oversampling;
 _B3 += 2;
 _B3 >>= 2;

 X1 = (Cal.AC3 * _B6);
 X1 >>= 13;

 X2 = (_B6 * _B6);
 X2 >>= 12;
 X2 *= Cal.mB1;
 X2 >>= 8;
 X2 >>= 8;

 X3 = ((X1 + X2) + 2 );
 X3 >>= 2;

 _B4 = Cal.AC4;
 _B4 *= (unsigned long)(X3 + 32768);
 _B4 >>= 15;

 _B7 = (unsigned long)(UP - _B3);
 _B7 *= (unsigned long)(50000 >> oversampling);

 if( _B7 < 0x80000000 )
 {
 pp = ((_B7 * 2) / _B4);

 }
 else
 {
 pp = ((_B7 / _B4) * 2);
 }

 X1 = pow((pp >> 8), 2);
 X1 *= 1519;
 X1 >>= 15;

 X2 = (-7357 * pp);
 X2 >>= 8;
 X2 >>= 8;

 Bar->Pressao = pp + ( (X1 + X2 + 3791) >> 4);


 Bar->Altitude = 1 - pow( (Bar->Pressao / 101035), 0.190295 );
 Bar->Altitude *= 44330;
 return;
}
#line 13 "F:/Workspace/Projeler/IHA/BMP085/pressure_sensor_bmp085.c"
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD2_bit;
sbit LCD_D5 at RD3_bit;
sbit LCD_D6 at RD4_bit;
sbit LCD_D7 at RD5_bit;

sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD2_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D7_Direction at TRISD5_bit;



char text[12];
BMP085 Bar;

void main()
{
 ADCON1 = 0x0F;

 Lcd_Init();
 Lcd_Cmd( _LCD_CLEAR );

 I2C1_Init(100000);
 BMP085_Init();

 while(1)
 {
 BMP085_Read(  0 , &Bar );

 LongWordToStr( Bar.Pressao, text );
 LTrim( text );
 Lcd_Out( 1, 1, "P: " );
 Lcd_Out_CP( text );
 Lcd_Out_CP( "Pa" );

 IntToStr( Bar.Altitude, text );
 LTrim( text );
 Lcd_Out( 2, 1, "A: " );
 Lcd_Out_CP( text );
 Lcd_Out_CP( "m" );

 Delay_ms( 500 );
 }
}
