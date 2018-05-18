_MPU6050_Init:
;mpu6050_i2c1.c,4 :: 		void MPU6050_Init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;mpu6050_i2c1.c,7 :: 		MPU6050_I2C_Init();
BL	_Soft_I2C_Init+0
;mpu6050_i2c1.c,8 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;mpu6050_i2c1.c,9 :: 		err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
MOVS	R0, #208
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,10 :: 		err=MPU6050_I2C_Wr( MPU6050_RA_PWR_MGMT_1 );
MOVS	R0, #107
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,11 :: 		err=MPU6050_I2C_Wr( 2 ); //Sleep OFF
MOVS	R0, #2
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,12 :: 		err=MPU6050_I2C_Wr( 0 );
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,13 :: 		MPU6050_I2C_Stop();
BL	_Soft_I2C_Stop+0
;mpu6050_i2c1.c,14 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;mpu6050_i2c1.c,15 :: 		err=MPU6050_I2C_Wr( MPU6050_ADDRESS );
MOVS	R0, #208
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,16 :: 		err=MPU6050_I2C_Wr( MPU6050_RA_GYRO_CONFIG );
MOVS	R0, #27
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,17 :: 		err=MPU6050_I2C_Wr( 0 ); //gyro_config, +-250 °/s
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,18 :: 		err=MPU6050_I2C_Wr( 0 ); //accel_config +-2g
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,19 :: 		MPU6050_I2C_Stop();
BL	_Soft_I2C_Stop+0
;mpu6050_i2c1.c,21 :: 		delay_ms(100);
MOVW	R7, #29438
MOVT	R7, #85
NOP
NOP
L_MPU6050_Init0:
SUBS	R7, R7, #1
BNE	L_MPU6050_Init0
NOP
NOP
NOP
;mpu6050_i2c1.c,22 :: 		}
L_end_MPU6050_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MPU6050_Init
_MPU6050_Read:
;mpu6050_i2c1.c,23 :: 		void MPU6050_Read( MPU6050 *Sensor ) //creates a pointer(*sensor) to a variable of the MPU6050 type.
; Sensor start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R6, R0
; Sensor end address is: 0 (R0)
; Sensor start address is: 24 (R6)
;mpu6050_i2c1.c,40 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;mpu6050_i2c1.c,41 :: 		MPU6050_I2C_Wr( MPU6050_ADDRESS );
MOVS	R0, #208
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,42 :: 		MPU6050_I2C_Wr( MPU6050_RA_ACCEL_XOUT_H );
MOVS	R0, #59
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,43 :: 		MPU6050_I2C_Start();
BL	_Soft_I2C_Start+0
;mpu6050_i2c1.c,44 :: 		MPU6050_I2C_Wr( MPU6050_ADDRESS | 1 );
MOVS	R0, #209
BL	_Soft_I2C_Write+0
;mpu6050_i2c1.c,46 :: 		Sensor->Accel.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1); //the pointer puts de read value on the Accel.X variable (part of MPU6050 struct)
MOV	R1, R6
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
;mpu6050_i2c1.c,48 :: 		accelx=Sensor->Accel.X;
LDRSH	R2, [R6, #0]
MOVW	R1, #lo_addr(MPU6050_Read_accelx_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelx_L0+0)
STRH	R2, [R1, #0]
;mpu6050_i2c1.c,50 :: 		Sensor->Accel.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDS	R1, R6, #2
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
;mpu6050_i2c1.c,51 :: 		accely=Sensor->Accel.Y;
ADDS	R1, R6, #2
LDRSH	R2, [R1, #0]
MOVW	R1, #lo_addr(MPU6050_Read_accely_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accely_L0+0)
STRH	R2, [R1, #0]
;mpu6050_i2c1.c,54 :: 		Sensor->Accel.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDS	R1, R6, #4
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
;mpu6050_i2c1.c,55 :: 		accelz=Sensor->Accel.Z;
ADDS	R1, R6, #4
LDRSH	R2, [R1, #0]
MOVW	R1, #lo_addr(MPU6050_Read_accelz_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelz_L0+0)
STRH	R2, [R1, #0]
;mpu6050_i2c1.c,62 :: 		arx = (57.29579) * atan(accelx / sqrt(pow(accely, 2) + pow(accelz, 2))); //constant coming from 180/3.14
MOVW	R1, #lo_addr(MPU6050_Read_accely_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accely_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VMOV.F32	S1, #2
BL	_pow+0
VSTR	#1, S0, [SP, #4]
MOVW	R1, #lo_addr(MPU6050_Read_accelz_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelz_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VMOV.F32	S1, #2
BL	_pow+0
VLDR	#1, S1, [SP, #4]
VADD.F32	S0, S1, S0
BL	_sqrt+0
MOVW	R1, #lo_addr(MPU6050_Read_accelx_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelx_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S1, R1
VCVT.F32	#1, S1, S1
VDIV.F32	S0, S1, S0
BL	_atan+0
MOVW	R1, #12004
MOVT	R1, #16997
VMOV	S1, R1
VMUL.F32	S0, S1, S0
MOVW	R1, #lo_addr(MPU6050_Read_arx_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_arx_L0+0)
VSTR	#1, S0, [R1, #0]
;mpu6050_i2c1.c,63 :: 		ary = (57.29579) * atan(accely / sqrt(pow(accelx, 2) + pow(accelz, 2)));
MOVW	R1, #lo_addr(MPU6050_Read_accelx_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelx_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VMOV.F32	S1, #2
BL	_pow+0
VSTR	#1, S0, [SP, #4]
MOVW	R1, #lo_addr(MPU6050_Read_accelz_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelz_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VMOV.F32	S1, #2
BL	_pow+0
VLDR	#1, S1, [SP, #4]
VADD.F32	S0, S1, S0
BL	_sqrt+0
MOVW	R1, #lo_addr(MPU6050_Read_accely_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accely_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S1, R1
VCVT.F32	#1, S1, S1
VDIV.F32	S0, S1, S0
BL	_atan+0
MOVW	R1, #12004
MOVT	R1, #16997
VMOV	S1, R1
VMUL.F32	S0, S1, S0
MOVW	R1, #lo_addr(MPU6050_Read_ary_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_ary_L0+0)
VSTR	#1, S0, [R1, #0]
;mpu6050_i2c1.c,64 :: 		arz = (57.29579) * atan(sqrt(pow(accely,2) + pow(accelx,2)) / accelz);
MOVW	R1, #lo_addr(MPU6050_Read_accely_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accely_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VMOV.F32	S1, #2
BL	_pow+0
VSTR	#1, S0, [SP, #4]
MOVW	R1, #lo_addr(MPU6050_Read_accelx_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelx_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S0, R1
VCVT.F32	#1, S0, S0
VMOV.F32	S1, #2
BL	_pow+0
VLDR	#1, S1, [SP, #4]
VADD.F32	S0, S1, S0
BL	_sqrt+0
MOVW	R1, #lo_addr(MPU6050_Read_accelz_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_accelz_L0+0)
LDRSH	R1, [R1, #0]
VMOV	S1, R1
VCVT.F32	#1, S1, S1
VDIV.F32	S0, S0, S1
BL	_atan+0
MOVW	R1, #12004
MOVT	R1, #16997
VMOV	S1, R1
VMUL.F32	S0, S1, S0
MOVW	R3, #lo_addr(MPU6050_Read_arz_L0+0)
MOVT	R3, #hi_addr(MPU6050_Read_arz_L0+0)
VSTR	#1, S0, [R3, #0]
;mpu6050_i2c1.c,66 :: 		Sensor->AccelAngle.X=arx;
ADDW	R2, R6, #20
MOVW	R1, #lo_addr(MPU6050_Read_arx_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_arx_L0+0)
VLDR	#1, S0, [R1, #0]
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
SXTH	R1, R1
STRH	R1, [R2, #0]
;mpu6050_i2c1.c,67 :: 		Sensor->AccelAngle.Y=ary;
ADDW	R1, R6, #20
ADDS	R2, R1, #2
MOVW	R1, #lo_addr(MPU6050_Read_ary_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_ary_L0+0)
VLDR	#1, S0, [R1, #0]
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
SXTH	R1, R1
STRH	R1, [R2, #0]
;mpu6050_i2c1.c,68 :: 		Sensor->AccelAngle.Z=arz;
ADDW	R1, R6, #20
ADDS	R2, R1, #4
MOV	R1, R3
VLDR	#1, S0, [R1, #0]
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
SXTH	R1, R1
STRH	R1, [R2, #0]
;mpu6050_i2c1.c,71 :: 		Sensor->Temperatura = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDS	R1, R6, #6
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
;mpu6050_i2c1.c,72 :: 		Sensor->Gyro.X = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
ADDW	R1, R6, #8
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
;mpu6050_i2c1.c,73 :: 		gyrox= Sensor->Gyro.X;
ADDW	R1, R6, #8
;mpu6050_i2c1.c,75 :: 		Sensor->Gyro.Y = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(1);
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
;mpu6050_i2c1.c,76 :: 		gyroy= Sensor->Gyro.Y;
ADDW	R1, R6, #8
;mpu6050_i2c1.c,78 :: 		Sensor->Gyro.Z = ( MPU6050_I2C_Rd(1) << 8 ) | MPU6050_I2C_Rd(0);
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
;mpu6050_i2c1.c,86 :: 		if (i == 1) {
MOVW	R1, #lo_addr(MPU6050_Read_i_L0+0)
MOVT	R1, #hi_addr(MPU6050_Read_i_L0+0)
LDRSH	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L_MPU6050_Read2
;mpu6050_i2c1.c,90 :: 		i=i+1;
MOVW	R2, #lo_addr(MPU6050_Read_i_L0+0)
MOVT	R2, #hi_addr(MPU6050_Read_i_L0+0)
LDRSH	R1, [R2, #0]
ADDS	R1, R1, #1
STRH	R1, [R2, #0]
;mpu6050_i2c1.c,91 :: 		}
IT	AL
BAL	L_MPU6050_Read3
L_MPU6050_Read2:
;mpu6050_i2c1.c,97 :: 		i=i+1;
MOVW	R2, #lo_addr(MPU6050_Read_i_L0+0)
MOVT	R2, #hi_addr(MPU6050_Read_i_L0+0)
LDRSH	R1, [R2, #0]
ADDS	R1, R1, #1
STRH	R1, [R2, #0]
;mpu6050_i2c1.c,98 :: 		}
L_MPU6050_Read3:
;mpu6050_i2c1.c,103 :: 		MPU6050_I2C_Stop();
BL	_Soft_I2C_Stop+0
;mpu6050_i2c1.c,105 :: 		Sensor->Temperatura += 12421;
ADDS	R3, R6, #6
LDRSH	R2, [R3, #0]
MOVW	R1, #12421
SXTH	R1, R1
ADDS	R1, R2, R1
STRH	R1, [R3, #0]
;mpu6050_i2c1.c,106 :: 		Sensor->Temperatura /= 340;
ADDS	R3, R6, #6
; Sensor end address is: 24 (R6)
LDRSH	R2, [R3, #0]
MOVW	R1, #340
SXTH	R1, R1
SDIV	R1, R2, R1
STRH	R1, [R3, #0]
;mpu6050_i2c1.c,108 :: 		}
L_end_MPU6050_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MPU6050_Read
_main:
;main.c,13 :: 		void main() {
;main.c,16 :: 		MPU6050_Init();
BL	_MPU6050_Init+0
;main.c,19 :: 		while(1){
L_main4:
;main.c,20 :: 		MPU6050_Read( &Sensor );
MOVW	R0, #lo_addr(_Sensor+0)
MOVT	R0, #hi_addr(_Sensor+0)
BL	_MPU6050_Read+0
;main.c,22 :: 		xg=Sensor.Accel.X;
MOVW	R0, #lo_addr(_Sensor+0)
MOVT	R0, #hi_addr(_Sensor+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_xg+0)
MOVT	R0, #hi_addr(_xg+0)
STRH	R1, [R0, #0]
;main.c,23 :: 		xangle=Sensor.AccelAngle.X;
MOVW	R0, #lo_addr(_Sensor+20)
MOVT	R0, #hi_addr(_Sensor+20)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_xangle+0)
MOVT	R0, #hi_addr(_xangle+0)
STRH	R1, [R0, #0]
;main.c,27 :: 		}
IT	AL
BAL	L_main4
;main.c,28 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
