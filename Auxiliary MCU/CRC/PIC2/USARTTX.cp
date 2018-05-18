#line 1 "C:/Users/lenovo/Desktop/CRC/PIC2/USARTTX.c"

char crc_data[10]="";
char gelen[10]="";


void interrupt()
{
if(PIR1.RCIF)
{
 PIR1.RCIF=0;

 UART1_Read_Text(gelen,"OK", 30);
 if(gelen[0]==crc_data[0])
 {
 PORTC.F0=1;
 delay_ms(100);
 PORTC.F0=0;

 }




 PIR1.RCIF=0;

}
}



void main()
{ unsigned int k=255,l=5;
 TRISB = 0xFF;
 PORTB = 0;
TRISC.F0=0;
PORTC.F0=0;



 UART1_Init(9600);
 INTCON.GIE = 1;
 PIE1.RCIE = 1;
 INTCON.PEIE = 1;
 PIR1.RCIF=0;
 RCSTA.CREN=1;

 while (1)
 {


 crc_data[0]=55;

 UART1_Write(crc_data[0]);

 crc_data[1]='O';

 UART1_Write(crc_data[1]);
 crc_data[2]='K';

 UART1_Write(crc_data[2]);



 delay_ms(99);





 }
}
