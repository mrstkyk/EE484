#line 1 "F:/Workspace/Projeler/IHA/HMC5883L_STM32F407VG_MikroC/main.c"
#line 1 "f:/workspace/projeler/iha/hmc5883l_stm32f407vg_mikroc/hmc5883l.c"
#line 1 "f:/workspace/projeler/iha/hmc5883l_stm32f407vg_mikroc/hmc5883l.h"
#line 26 "f:/workspace/projeler/iha/hmc5883l_stm32f407vg_mikroc/hmc5883l.h"
signed int X_axis = 0;
signed int Y_axis = 0;
signed int Z_axis = 0;
float m_scale = 1.0;


unsigned int make_word(unsigned char HB, unsigned char LB);
void HMC5883L_init();
unsigned char HMC5883L_read(unsigned char reg);
void HMC5883L_write(unsigned char reg_address, unsigned char value);
void HMC5883L_read_data();
void HMC5883L_scale_axes();
void HMC5883L_set_scale(float gauss);
signed long HMC5883L_heading();
#line 4 "f:/workspace/projeler/iha/hmc5883l_stm32f407vg_mikroc/hmc5883l.c"
unsigned int make_word(unsigned char HB, unsigned char LB)
{
 unsigned int val = 0;

 val = HB;
 val <<= 8;
 val |= LB;

 return val;
}


void HMC5883L_init()
{
 Soft_I2C_Init();
 delay_ms(100);
 Soft_I2C_Break();
 HMC5883L_write( 0x00 , 0x70);
 HMC5883L_write( 0x01 , 0xA0);
 HMC5883L_write( 0x02 , 0x00);
 HMC5883L_set_scale(1.3);
}


unsigned char HMC5883L_read(unsigned char reg)
{
 unsigned char val = 0;

 Soft_I2C_Start();
 Soft_I2C_Write( 0x3C );
 Soft_I2C_Write(reg);
 Soft_I2C_Start();
 Soft_I2C_Write( 0x3D );
 val = Soft_I2C_Read(0);
 Soft_I2C_Stop();

 return(val);
}


void HMC5883L_write(unsigned char reg_address, unsigned char value)
{
 Soft_I2C_Start();
 Soft_I2C_Write( 0x3C );
 Soft_I2C_Write(reg_address);
 Soft_I2C_Write(value);
 Soft_I2C_Stop();
}

void HMC5883L_read_data()
{
 unsigned char lsb = 0;
 unsigned char msb = 0;

 Soft_I2C_Start();
 Soft_I2C_Write( 0x3C );
 Soft_I2C_Write( 0x03 );
 Soft_I2C_Start();
 Soft_I2C_Write( 0x3D );

 msb = Soft_I2C_Read(1);
 lsb = Soft_I2C_Read(1);
 X_axis = make_word(msb, lsb);

 msb = Soft_I2C_Read(1);
 lsb = Soft_I2C_Read(1);
 Z_axis = make_word(msb, lsb);

 msb = Soft_I2C_Read(1);
 lsb = Soft_I2C_Read(0);
 Y_axis = make_word(msb, lsb);

 Soft_I2C_Stop();
}


void HMC5883L_scale_axes()
{
 X_axis *= m_scale;
 Z_axis *= m_scale;
 Y_Axis *= m_scale;
}


void HMC5883L_set_scale(float gauss)
{
 unsigned char value = 0;

 if(gauss == 0.88)
 {
 value = 0x00;
 m_scale = 0.73;
 }

 else if(gauss == 1.3)
 {
 value = 0x01;
 m_scale = 0.92;
 }

 else if(gauss == 1.9)
 {
 value = 0x02;
 m_scale = 1.22;
 }

 else if(gauss == 2.5)
 {
 value = 0x03;
 m_scale = 1.52;
 }

 else if(gauss == 4.0)
 {
 value = 0x04;
 m_scale = 2.27;
 }

 else if(gauss == 4.7)
 {
 value = 0x05;
 m_scale = 2.56;
 }

 else if(gauss == 5.6)
 {
 value = 0x06;
 m_scale = 3.03;
 }

 else if(gauss == 8.1)
 {
 value = 0x07;
 m_scale = 4.35;
 }

 value <<= 5;
 HMC5883L_write( 0x01 , value);
}


signed long HMC5883L_heading()
{
 float heading = 0.0;

 HMC5883L_read_data();
 HMC5883L_scale_axes();
 heading = atan2(Y_axis, X_axis);
 heading +=  -0.5167 ;

 if(heading < 0.0)
 {
 heading += (2.0 *  3.142 );
 }

 if(heading > (2.0 *  3.142 ))
 {
 heading -= (2.0 *  3.142 );
 }

 heading *= (180.0 /  3.142 );

 return heading;
}
#line 19 "F:/Workspace/Projeler/IHA/HMC5883L_STM32F407VG_MikroC/main.c"
sbit Soft_I2C_Scl_Output at GPIOD_ODR.B3;
sbit Soft_I2C_Scl_Input at GPIOD_IDR.B3;
sbit Soft_I2C_Sda_Output at GPIOD_ODR.B4;
sbit Soft_I2C_Sda_Input at GPIOD_IDR.B4;


 int X_out;
 int Y_out;
 int Z_out;
 signed long h;
 unsigned char value=0;

void main() {


HMC5883L_Init();
 while(1)
 {
 h = HMC5883L_heading();

 delay_ms(100);
 };

}
