// Lcd pinout settings
sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;


char txt[768];
char *string;
int i ;
unsigned int hour, minute;
unsigned short ready;
char hh[4], mm[4];

void interrupt() {
  if (RCIF_bit == 1) {             // If interrupt is generated by RCIF
    txt[i] = UART_Read();         // Read data and store it to txrt string
    i++;                           // Increment string index
    if (i == 768) {                // If index = 768,
      i = 0;                       //   set it to zero
      ready = 1;                     // Ready for parsing GPS data
      }
  RCIF_bit = 0;                    // Set RCIF to 0 register for uart interrupt
  }
}

void main(){
 /*ANSELB = 0;                        // Configure PORTB pins as digital
  ANSELD=0;
  ANSELC=0;*/

  ADCON1=0X0F;
  CMCON=7;
  Lcd_Init();                        // Initialize Lcd

  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_out(1,1,"GPS Time:");
  Lcd_out(2,1,"Waiting");

  ready = 0;                       // Initialize variables
  i = 0;

  UART1_Init(9600);                // Initialize UART module at 9600
//  UART2_Init(9600);   // for ttl

  RCIE_bit = 1;                   // Enable USART Receiver interrupt
  GIE_bit = 1;                     // Enable Global interrupt
  PEIE_bit = 1;                    // Enable Peripheral interrupt

  while(1) {
    OERR_bit = 0;                 // Set OERR to 0  overrun error bit in uart
    FERR_bit = 0;                 // Set FERR to 0  framming error bit in uart

    if(ready == 1) {               // If the data in txt array is ready do:
      ready = 0;
      string = strstr(txt,"$GPGGA");   //locates the first position of $GPGLL in txt
      //if(string[0] == '$' && string[1] == 'G' && string[2] == 'P' && string[3] == 'G' && string[4] == 'G' &&   string[5] == 'A')
      if(string != 0) {            // If txt array contains "$GPGLL" string we proceed...
        if(string[7] != ',') {     // If "$GPGLL" NMEA message have ',' sign in the 8-th
                                   // position it means that tha GPS receiver does not have FIXed position!



          Lcd_Cmd(_LCD_CLEAR);
                         Lcd_Cmd(_LCD_CURSOR_OFF);

                            Lcd_out(1,1,"time=");
                            Lcd_Chr_Cp(string[7]);
                            Lcd_Chr_Cp(string[8]);
                            Lcd_Chr_Cp(':');
                            Lcd_Chr_Cp(string[9]);
                            Lcd_Chr_Cp(string[10]);
                            Lcd_out(2,1,"lat=");
                            Lcd_Chr_Cp(string[17]);
                            Lcd_Chr_Cp(string[18]);
                            Lcd_Chr_Cp(string[19]);
                            Lcd_Chr_Cp(string[20]);
                            Lcd_Chr_Cp(string[28]);


                           Lcd_out(3,1,"long=");
                           Lcd_Chr_Cp(string[30]);
                           Lcd_Chr_Cp(string[31]);
                           Lcd_Chr_Cp(string[32]);
                           Lcd_Chr_Cp(string[33]);
                           Lcd_Chr_Cp(string[42]);




        }
      }
    }
  }
}