
char crc_data[10]="";
char gelen[10]="";


void interrupt()
{
if(PIR1.RCIF)
{
 PIR1.RCIF=0;   
 
 //7OK
 UART1_Read_Text(gelen,"OK", 30);    // reads text until 'OK' is found
 if(gelen[0]==crc_data[0])
 {
  PORTC.F0=1;
  delay_ms(100);
  PORTC.F0=0;                          //LED 0
 
 }
 



 PIR1.RCIF=0;                         //FLAG TEMÝZLENDÝ

}
}



void main()
{

TRISC.F0=0;
PORTC.F0=0;

 ////////////////////////////// UART AYARLARI /////////////////////////////////////

 UART1_Init(9600);    // UART 9600 Baudrate ile baslatýldý.
 INTCON.GIE = 1;      // GLOBAL INTERRUPT ENABLE
 PIE1.RCIE = 1;       // RECIEVE INTERRUPT ENABLE
 INTCON.PEIE = 1;     // peripheral intterrupt
 PIR1.RCIF=0;         // RX FLAG BIT
 RCSTA.CREN=1;
 ///////////////////////////// UART AYARLARI SONU //////////////////////////////////
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
