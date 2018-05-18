_MPU6050_Init:
;tmp.c,162 :: 		void MPU6050_Init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tmp.c,165 :: 		MPU6050_I2C_Init();
BL	_Soft_I2C_Init+0
;tmp.c,166 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;tmp.c,167 :: 		err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
MOVS	R0, #210
BL	_Soft_I2C_Write+0
;tmp.c,168 :: 		err=MPU6050_I2C_Wr( MPU6050_RA_PWR_MGMT_1 );
MOVS	R0, #107
BL	_Soft_I2C_Write+0
;tmp.c,169 :: 		err=MPU6050_I2C_Wr( 2 ); //Sleep OFF
MOVS	R0, #2
BL	_Soft_I2C_Write+0
;tmp.c,170 :: 		err=MPU6050_I2C_Wr( 0 );
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;tmp.c,171 :: 		MPU6050_I2C_Stop();
BL	_Soft_I2C_Stop+0
;tmp.c,172 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;tmp.c,173 :: 		err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
MOVS	R0, #210
BL	_Soft_I2C_Write+0
;tmp.c,174 :: 		err=MPU6050_I2C_Wr( MPU6050_RA_GYRO_CONFIG );
MOVS	R0, #27
BL	_Soft_I2C_Write+0
;tmp.c,175 :: 		err=MPU6050_I2C_Wr( 0 ); //gyro_config, +-250 °/s
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;tmp.c,176 :: 		err=MPU6050_I2C_Wr( 0 ); //accel_config +-2g
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;tmp.c,177 :: 		MPU6050_I2C_Stop();
BL	_Soft_I2C_Stop+0
;tmp.c,179 :: 		delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_MPU6050_Init0:
SUBS	R7, R7, #1
BNE	L_MPU6050_Init0
NOP
NOP
NOP
NOP
;tmp.c,180 :: 		}
L_end_MPU6050_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MPU6050_Init
_MPU6050_Read:
;tmp.c,181 :: 		void MPU6050_Read( MPU6050 *Sensor ) //creates a pointer(*sensor) to a variable of the MPU6050 type.
; Sensor start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R5, R0
; Sensor end address is: 0 (R0)
; Sensor start address is: 20 (R5)
;tmp.c,183 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;tmp.c,184 :: 		MPU6050_I2C_Wr( MPU6050_ADDRESS );
MOVS	R0, #210
BL	_Soft_I2C_Write+0
;tmp.c,185 :: 		MPU6050_I2C_Wr( MPU6050_RA_ACCEL_XOUT_H );
MOVS	R0, #59
BL	_Soft_I2C_Write+0
;tmp.c,186 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;tmp.c,187 :: 		MPU6050_I2C_Wr( MPU6050_ADDRESS | 1 );
MOVS	R0, #211
BL	_Soft_I2C_Write+0
;tmp.c,188 :: 		Sensor->Accel.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1); //the pointer puts de read value on the Accel.X variable (part of MPU6050 struct)
MOV	R1, R5
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,189 :: 		Sensor->Accel.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDS	R1, R5, #2
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,190 :: 		Sensor->Accel.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDS	R1, R5, #4
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,191 :: 		Sensor->Temperature = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDS	R1, R5, #6
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,192 :: 		Sensor->Gyro.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDW	R1, R5, #8
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,193 :: 		Sensor->Gyro.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDW	R1, R5, #8
ADDS	R1, R1, #2
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,194 :: 		Sensor->Gyro.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(0);
ADDW	R1, R5, #8
ADDS	R1, R1, #4
STR	R1, [SP, #8]
MOVS	R0, #1
BL	_Soft_I2C_Read+0
LSLS	R1, R0, #8
STRH	R1, [SP, #4]
MOVS	R0, #0
BL	_Soft_I2C_Read+0
LDRH	R1, [SP, #4]
ORR	R2, R1, R0, LSL #0
LDR	R1, [SP, #8]
STRH	R2, [R1, #0]
;tmp.c,195 :: 		MPU6050_I2C_Stop();
BL	_Soft_I2C_Stop+0
;tmp.c,196 :: 		Sensor->Temperature += 12421;
ADDS	R3, R5, #6
LDRSH	R2, [R3, #0]
MOVW	R1, #12421
SXTH	R1, R1
ADDS	R1, R2, R1
STRH	R1, [R3, #0]
;tmp.c,197 :: 		Sensor->Temperature /= 340;
ADDS	R3, R5, #6
; Sensor end address is: 20 (R5)
LDRSH	R2, [R3, #0]
MOVW	R1, #340
SXTH	R1, R1
SDIV	R1, R2, R1
STRH	R1, [R3, #0]
;tmp.c,198 :: 		UART1_write_text("asd");
MOVW	R1, #lo_addr(?lstr1_tmp+0)
MOVT	R1, #hi_addr(?lstr1_tmp+0)
MOV	R0, R1
BL	_UART1_Write_Text+0
;tmp.c,199 :: 		}
L_end_MPU6050_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MPU6050_Read
_main:
;tmp.c,204 :: 		void main(){
SUB	SP, SP, #4
;tmp.c,207 :: 		MPU6050_Init();
BL	_MPU6050_Init+0
;tmp.c,208 :: 		UART1_Init(9600);
MOVW	R0, #9600
BL	_UART1_Init+0
;tmp.c,212 :: 		delay_ms(100);
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
NOP
;tmp.c,216 :: 		while(1){
L_main4:
;tmp.c,218 :: 		MPU6050_Read( &Sensor );
MOVW	R0, #lo_addr(_Sensor+0)
MOVT	R0, #hi_addr(_Sensor+0)
BL	_MPU6050_Read+0
;tmp.c,220 :: 		UART1_Write(Sensor.Gyro.X);
MOVW	R0, #lo_addr(_Sensor+8)
MOVT	R0, #hi_addr(_Sensor+8)
LDRSH	R0, [R0, #0]
BL	_UART1_Write+0
;tmp.c,221 :: 		delay_ms(100);
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
NOP
NOP
;tmp.c,222 :: 		UART1_Write(Sensor.Gyro.Y);
MOVW	R0, #lo_addr(_Sensor+10)
MOVT	R0, #hi_addr(_Sensor+10)
LDRSH	R0, [R0, #0]
BL	_UART1_Write+0
;tmp.c,223 :: 		delay_ms(100);
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main8:
SUBS	R7, R7, #1
BNE	L_main8
NOP
NOP
NOP
NOP
;tmp.c,224 :: 		UART1_Write(Sensor.Gyro.Z);
MOVW	R0, #lo_addr(_Sensor+12)
MOVT	R0, #hi_addr(_Sensor+12)
LDRSH	R0, [R0, #0]
BL	_UART1_Write+0
;tmp.c,225 :: 		delay_ms(100);
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main10:
SUBS	R7, R7, #1
BNE	L_main10
NOP
NOP
NOP
NOP
;tmp.c,228 :: 		}
IT	AL
BAL	L_main4
;tmp.c,230 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
