#line 1 "C:/Users/infcomp1/Desktop/GPS/GPS.c"

sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;


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
 if (RCIF_bit == 1) {
 txt[i] = UART_Read();
 i++;
 if (i == 768) {
 i = 0;
 ready = 1;
 }
 RCIF_bit = 0;
 }
}

void main(){
#line 42 "C:/Users/infcomp1/Desktop/GPS/GPS.c"
 ADCON1=0X0F;
 CMCON=7;
 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_out(1,1,"GPS Time:");
 Lcd_out(2,1,"Waiting");

 ready = 0;
 i = 0;

 UART1_Init(9600);


 RCIE_bit = 1;
 GIE_bit = 1;
 PEIE_bit = 1;

 while(1) {
 OERR_bit = 0;
 FERR_bit = 0;

 if(ready == 1) {
 ready = 0;
 string = strstr(txt,"$GPGGA");

 if(string != 0) {
 if(string[7] != ',') {




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
