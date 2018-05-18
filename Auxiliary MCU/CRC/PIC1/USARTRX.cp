#line 1 "C:/Users/lenovo/Desktop/CRC/PIC1/USARTRX.c"
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

char txt1[5]="K";

char output[10]="";

int k=0,l=0;


void interrupt()
{

if(PIR1.RCIF)
{

 PIR1.RCIF=0;
 PORTC.F0=1;
 UART1_Read_Text(output,"OK", 30);
#line 35 "C:/Users/lenovo/Desktop/CRC/PIC1/USARTRX.c"
 UART1_Write_Text(output); UART1_Write(79); UART1_Write(75);


}
}

void main()
{

 TRISC.F0=0;
 PORTC.F0=0;
 Lcd_Init();

 TRISB = 0;
 PORTB = 0;


 UART1_Init(9600);
 INTCON.GIE = 1;
 PIE1.RCIE = 1;
 INTCON.PEIE = 1;
 PIR1.RCIF=0;
 RCSTA.CREN=1;



 while (1)
 {




 }
 }
