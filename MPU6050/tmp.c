 /*
 
 
 @19.02.2018 /21:46
 @Editing by mrstkyk
 @This code is optimized for STM32F407VG Dev. Board
 
 @I2C Communication Connection  -->  B6->SCL , B7->SDA
 @UART Communication Connection -->  A9->TX  , A10->RX
 
 */

 #define MPU6050_I2C_Wr Soft_I2C_Write
 #define MPU6050_I2C_Rd Soft_I2C_Read
 #define MPU6050_I2C_Stop Soft_I2C_Stop
 #define MPU6050_I2C_Start Soft_I2C_Start
 #define MPU6050_I2C_Init Soft_I2C_Init


#define MPU6050_ADDRESS   0xD2
#define MPU6050_RA_XG_OFFS_TC       0x00
#define MPU6050_RA_YG_OFFS_TC       0x01
#define MPU6050_RA_ZG_OFFS_TC       0x02
#define MPU6050_RA_X_FINE_GAIN      0x03
#define MPU6050_RA_Y_FINE_GAIN      0x04
#define MPU6050_RA_Z_FINE_GAIN      0x05
#define MPU6050_RA_XA_OFFS_H        0x06
#define MPU6050_RA_XA_OFFS_L_TC     0x07
#define MPU6050_RA_YA_OFFS_H        0x08
#define MPU6050_RA_YA_OFFS_L_TC     0x09
#define MPU6050_RA_ZA_OFFS_H        0x0A
#define MPU6050_RA_ZA_OFFS_L_TC     0x0B
#define MPU6050_RA_XG_OFFS_USRH     0x13
#define MPU6050_RA_XG_OFFS_USRL     0x14
#define MPU6050_RA_YG_OFFS_USRH     0x15
#define MPU6050_RA_YG_OFFS_USRL     0x16
#define MPU6050_RA_ZG_OFFS_USRH     0x17
#define MPU6050_RA_ZG_OFFS_USRL     0x18
#define MPU6050_RA_SMPLRT_DIV       0x19
#define MPU6050_RA_CONFIG           0x1A
#define MPU6050_RA_GYRO_CONFIG      0x1B
#define MPU6050_RA_ACCEL_CONFIG     0x1C
#define MPU6050_RA_FF_THR           0x1D
#define MPU6050_RA_FF_DUR           0x1E
#define MPU6050_RA_MOT_THR          0x1F
#define MPU6050_RA_MOT_DUR          0x20
#define MPU6050_RA_ZRMOT_THR        0x21
#define MPU6050_RA_ZRMOT_DUR        0x22
#define MPU6050_RA_FIFO_EN          0x23
#define MPU6050_RA_I2C_MST_CTRL     0x24
#define MPU6050_RA_I2C_SLV0_ADDR    0x25
#define MPU6050_RA_I2C_SLV0_REG     0x26
#define MPU6050_RA_I2C_SLV0_CTRL    0x27
#define MPU6050_RA_I2C_SLV1_ADDR    0x28
#define MPU6050_RA_I2C_SLV1_REG     0x29
#define MPU6050_RA_I2C_SLV1_CTRL    0x2A
#define MPU6050_RA_I2C_SLV2_ADDR    0x2B
#define MPU6050_RA_I2C_SLV2_REG     0x2C
#define MPU6050_RA_I2C_SLV2_CTRL    0x2D
#define MPU6050_RA_I2C_SLV3_ADDR    0x2E
#define MPU6050_RA_I2C_SLV3_REG     0x2F
#define MPU6050_RA_I2C_SLV3_CTRL    0x30
#define MPU6050_RA_I2C_SLV4_ADDR    0x31
#define MPU6050_RA_I2C_SLV4_REG     0x32
#define MPU6050_RA_I2C_SLV4_DO      0x33
#define MPU6050_RA_I2C_SLV4_CTRL    0x34
#define MPU6050_RA_I2C_SLV4_DI      0x35
#define MPU6050_RA_I2C_MST_STATUS   0x36
#define MPU6050_RA_INT_PIN_CFG      0x37
#define MPU6050_RA_INT_ENABLE       0x38
#define MPU6050_RA_DMP_INT_STATUS   0x39
#define MPU6050_RA_INT_STATUS       0x3A
#define MPU6050_RA_ACCEL_XOUT_H     0x3B
#define MPU6050_RA_ACCEL_XOUT_L     0x3C
#define MPU6050_RA_ACCEL_YOUT_H     0x3D
#define MPU6050_RA_ACCEL_YOUT_L     0x3E
#define MPU6050_RA_ACCEL_ZOUT_H     0x3F
#define MPU6050_RA_ACCEL_ZOUT_L     0x40
#define MPU6050_RA_TEMP_OUT_H       0x41
#define MPU6050_RA_TEMP_OUT_L       0x42
#define MPU6050_RA_GYRO_XOUT_H      0x43
#define MPU6050_RA_GYRO_XOUT_L      0x44
#define MPU6050_RA_GYRO_YOUT_H      0x45
#define MPU6050_RA_GYRO_YOUT_L      0x46
#define MPU6050_RA_GYRO_ZOUT_H      0x47
#define MPU6050_RA_GYRO_ZOUT_L      0x48
#define MPU6050_RA_EXT_SENS_DATA_00 0x49
#define MPU6050_RA_EXT_SENS_DATA_01 0x4A
#define MPU6050_RA_EXT_SENS_DATA_02 0x4B
#define MPU6050_RA_EXT_SENS_DATA_03 0x4C
#define MPU6050_RA_EXT_SENS_DATA_04 0x4D
#define MPU6050_RA_EXT_SENS_DATA_05 0x4E
#define MPU6050_RA_EXT_SENS_DATA_06 0x4F
#define MPU6050_RA_EXT_SENS_DATA_07 0x50
#define MPU6050_RA_EXT_SENS_DATA_08 0x51
#define MPU6050_RA_EXT_SENS_DATA_09 0x52
#define MPU6050_RA_EXT_SENS_DATA_10 0x53
#define MPU6050_RA_EXT_SENS_DATA_11 0x54
#define MPU6050_RA_EXT_SENS_DATA_12 0x55
#define MPU6050_RA_EXT_SENS_DATA_13 0x56
#define MPU6050_RA_EXT_SENS_DATA_14 0x57
#define MPU6050_RA_EXT_SENS_DATA_15 0x58
#define MPU6050_RA_EXT_SENS_DATA_16 0x59
#define MPU6050_RA_EXT_SENS_DATA_17 0x5A
#define MPU6050_RA_EXT_SENS_DATA_18 0x5B
#define MPU6050_RA_EXT_SENS_DATA_19 0x5C
#define MPU6050_RA_EXT_SENS_DATA_20 0x5D
#define MPU6050_RA_EXT_SENS_DATA_21 0x5E
#define MPU6050_RA_EXT_SENS_DATA_22 0x5F
#define MPU6050_RA_EXT_SENS_DATA_23 0x60
#define MPU6050_RA_MOT_DETECT_STATUS    0x61
#define MPU6050_RA_I2C_SLV0_DO      0x63
#define MPU6050_RA_I2C_SLV1_DO      0x64
#define MPU6050_RA_I2C_SLV2_DO      0x65
#define MPU6050_RA_I2C_SLV3_DO      0x66
#define MPU6050_RA_I2C_MST_DELAY_CTRL   0x67
#define MPU6050_RA_SIGNAL_PATH_RESET    0x68
#define MPU6050_RA_MOT_DETECT_CTRL      0x69
#define MPU6050_RA_USER_CTRL        0x6A
#define MPU6050_RA_PWR_MGMT_1       0x6B
#define MPU6050_RA_PWR_MGMT_2       0x6C
#define MPU6050_RA_BANK_SEL         0x6D
#define MPU6050_RA_MEM_START_ADDR   0x6E
#define MPU6050_RA_MEM_R_W          0x6F
#define MPU6050_RA_DMP_CFG_1        0x70
#define MPU6050_RA_DMP_CFG_2        0x71
#define MPU6050_RA_FIFO_COUNTH      0x72
#define MPU6050_RA_FIFO_COUNTL      0x73
#define MPU6050_RA_FIFO_R_W         0x74
#define MPU6050_RA_WHO_AM_I         0x75


//////////////////////////////////////////////////////////////////////////////// Bits configuration MPU6050 START
//
sbit Soft_I2C_Scl_Output    at GPIOB_ODR.B6;
sbit Soft_I2C_Scl_Input     at GPIOB_IDR.B6;
sbit Soft_I2C_Sda_Output    at GPIOB_ODR.B7;
sbit Soft_I2C_Sda_Input     at GPIOB_IDR.B7;

//////////////////////////////////////////////////////////////////////////////// Bits configuration MPU6050 END


//////////////////////////////////////////////////////////////////////////////// Variables declaritions START

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
}MPU6050; //Creats a struct of MPU6050 type (MPU6050 now is like int, char, etc)

void MPU6050_Init()
{
 short err;
 MPU6050_I2C_Init();
 MPU6050_I2C_Start();
 err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
 err=MPU6050_I2C_Wr( MPU6050_RA_PWR_MGMT_1 );
 err=MPU6050_I2C_Wr( 2 ); //Sleep OFF
 err=MPU6050_I2C_Wr( 0 );
 MPU6050_I2C_Stop();
 MPU6050_I2C_Start();
 err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
 err=MPU6050_I2C_Wr( MPU6050_RA_GYRO_CONFIG );
 err=MPU6050_I2C_Wr( 0 ); //gyro_config, +-250 �/s
 err=MPU6050_I2C_Wr( 0 ); //accel_config +-2g
 MPU6050_I2C_Stop();

 delay_ms(1000);
}
void MPU6050_Read( MPU6050 *Sensor ) //creates a pointer(*sensor) to a variable of the MPU6050 type.
{
 MPU6050_I2C_Start();
 MPU6050_I2C_Wr( MPU6050_ADDRESS );
 MPU6050_I2C_Wr( MPU6050_RA_ACCEL_XOUT_H );
 MPU6050_I2C_Start();
 MPU6050_I2C_Wr( MPU6050_ADDRESS | 1 );
 Sensor->Accel.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1); //the pointer puts de read value on the Accel.X variable (part of MPU6050 struct)
 Sensor->Accel.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 Sensor->Accel.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 Sensor->Temperature = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 Sensor->Gyro.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 Sensor->Gyro.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
 Sensor->Gyro.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(0);
 MPU6050_I2C_Stop();
 Sensor->Temperature += 12421;
 Sensor->Temperature /= 340;
 UART1_write_text("asd");
}

MPU6050 Sensor; //variavel global tipo Sensor


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