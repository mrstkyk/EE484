

#include <built_in.h>


        #define BMP085_I2C_Wr I2C1_Wr
        #define BMP085_I2C_Rd I2C1_Rd
        #define BMP085_I2C_Stop I2C1_Stop
        #define BMP085_I2C_Start I2C1_Start


#define BMP085_ADDRESS              0xEE

#define BMP085_ULTRALOWPOWER         0
#define BMP085_STANDARD              1
#define BMP085_HIGHRES               2
#define BMP085_ULTRAHIGHRES          3

//Calibration Data                            //Table 5 de yazmýþ
#define BMP085_CAL_AC1          0xAA //0
#define BMP085_CAL_AC2          0xAC //1
#define BMP085_CAL_AC3          0xAE //2
#define BMP085_CAL_AC4          0xB0 //3
#define BMP085_CAL_AC5          0xB2 //4
#define BMP085_CAL_AC6          0xB4 //5
#define BMP085_CAL_B1           0xB6 //6
#define BMP085_CAL_B2           0xB8 //7
#define BMP085_CAL_MB           0xBA //8
#define BMP085_CAL_MC           0xBC //9
#define BMP085_CAL_MD           0xBE //10


//Config register calibration
#define BMP085_CONTROL          0xF4     //Measurement Control
#define BMP085_TEMPDATA         0xF6
#define BMP085_PRESSUREDATA     0xF6
#define BMP085_READTEMPCMD      0x2E
#define BMP085_READPRESSURECMD  0x34

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
  BMP085_I2C_Start();
  BMP085_I2C_Wr( BMP085_ADDRESS ); 
  BMP085_I2C_Wr( BMP085_CAL_AC1 );
  BMP085_I2C_Start();
  BMP085_I2C_Wr( BMP085_ADDRESS | 1 );
  
  for( i=0; i < 10; i++)
  {
     ((int*)&Cal)[i] = (BMP085_I2C_Rd(1) << 8) + BMP085_I2C_Rd(1);
         
  }
  ((int*)&Cal)[10] = (BMP085_I2C_Rd(1) << 8) + BMP085_I2C_Rd(0);
  BMP085_I2C_Stop();
}

void BMP085_Read( char oversampling, BMP085 *Bar )
{
char cmd = 0x34;            //pressure oss=0 register
long UT=0, UP=0, _B3, _B5, _B6, X1, X2, X3, pp;
unsigned long _B4, _B7;

    
        //Read Uncompensated Temperature Value
    BMP085_I2C_Start();
    BMP085_I2C_Wr( BMP085_ADDRESS );
    BMP085_I2C_Wr( BMP085_CONTROL );
    BMP085_I2C_Wr( BMP085_READTEMPCMD );
    BMP085_I2C_Stop();
    
    Delay_ms( 5 );
    
    BMP085_I2C_Start();
    BMP085_I2C_Wr( BMP085_ADDRESS );
    BMP085_I2C_Wr( BMP085_TEMPDATA );
    BMP085_I2C_Start();
    BMP085_I2C_Wr( BMP085_ADDRESS | 1 );
    Hi(UT) = BMP085_I2C_Rd(1);
    Lo(UT) = BMP085_I2C_Rd(0);
    BMP085_I2C_Stop();
        
        //Read Uncompensated Pressure Value
    cmd.B6 = oversampling.B0;
    cmd.B7 = oversampling.B1;
    BMP085_I2C_Start();
    BMP085_I2C_Wr( BMP085_ADDRESS );
    BMP085_I2C_Wr( BMP085_CONTROL );
    BMP085_I2C_Wr( cmd );
    BMP085_I2C_Stop();

    switch(oversampling)
        {
                case 0: Delay_ms(5); break;    //3.3.1 de vermiþ bunlarý
                case 1: Delay_ms(8); break;
                case 2: Delay_ms(14); break;
                case 3: Delay_ms(26); break;
        }
           
    //while( EOF == 0 );

    BMP085_I2C_Start();
    BMP085_I2C_Wr( BMP085_ADDRESS );
    BMP085_I2C_Wr( BMP085_PRESSUREDATA );
    BMP085_I2C_Start();
    BMP085_I2C_Wr( BMP085_ADDRESS | 1 );
    Higher(UP) = BMP085_I2C_Rd(1);
    Hi(UP) = BMP085_I2C_Rd(1);
    Lo(UP) = BMP085_I2C_Rd(0);
    BMP085_I2C_Stop();
    Highest(UP) = 0;
    UP >>= ( 8 - oversampling );
        
        //Calcule True Temperature
    X1 = ( UT - Cal.AC6 );
        X1 *= Cal.AC5;
        X1 >>= 15;
        
        X2 = ((long)Cal.MC << 11);
        X2 /= (X1 + Cal.MD);
    
        _B5 = X1 + X2;
    
        Bar->Temperatura = ( (_B5 + 8) >> 4 ) / 10;
            
    //Calcule True Pressure
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
        
    //Calcula a Altitude
    Bar->Altitude = 1 - pow( (Bar->Pressao / 101035), 0.190295 );
    Bar->Altitude *= 44330;
    return;
}