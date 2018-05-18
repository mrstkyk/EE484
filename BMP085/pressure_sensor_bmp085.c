
#include "BMP085.c"

// LCD module connections
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
// End LCD module connections


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
       BMP085_Read( BMP085_ULTRALOWPOWER, &Bar );
       
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