_make_word:
;hmc5883l.c,4 :: 		unsigned int make_word(unsigned char HB, unsigned char LB)
; LB start address is: 4 (R1)
; HB start address is: 0 (R0)
SUB	SP, SP, #4
UXTB	R2, R0
; LB end address is: 4 (R1)
; HB end address is: 0 (R0)
; HB start address is: 8 (R2)
; LB start address is: 4 (R1)
;hmc5883l.c,6 :: 		unsigned int val = 0;
;hmc5883l.c,8 :: 		val = HB;
; val start address is: 0 (R0)
UXTB	R0, R2
; HB end address is: 8 (R2)
;hmc5883l.c,9 :: 		val <<= 8;
LSLS	R2, R0, #8
UXTH	R2, R2
; val end address is: 0 (R0)
;hmc5883l.c,10 :: 		val |= LB;
ORRS	R2, R1
; LB end address is: 4 (R1)
;hmc5883l.c,12 :: 		return val;
UXTH	R0, R2
;hmc5883l.c,13 :: 		}
L_end_make_word:
ADD	SP, SP, #4
BX	LR
; end of _make_word
_HMC5883L_init:
;hmc5883l.c,16 :: 		void HMC5883L_init()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;hmc5883l.c,18 :: 		Soft_I2C_Init();
BL	_Soft_I2C_Init+0
;hmc5883l.c,19 :: 		delay_ms(100);
MOVW	R7, #11305
MOVT	R7, #10
NOP
NOP
L_HMC5883L_init0:
SUBS	R7, R7, #1
BNE	L_HMC5883L_init0
NOP
NOP
;hmc5883l.c,20 :: 		Soft_I2C_Break();
BL	_Soft_I2C_Break+0
;hmc5883l.c,21 :: 		HMC5883L_write(Config_Reg_A, 0x70);
MOVS	R1, #112
MOVS	R0, #0
BL	_HMC5883L_write+0
;hmc5883l.c,22 :: 		HMC5883L_write(Config_Reg_B, 0xA0);
MOVS	R1, #160
MOVS	R0, #1
BL	_HMC5883L_write+0
;hmc5883l.c,23 :: 		HMC5883L_write(Mode_Reg, 0x00);
MOVS	R1, #0
MOVS	R0, #2
BL	_HMC5883L_write+0
;hmc5883l.c,24 :: 		HMC5883L_set_scale(1.3);
MOVW	R0, #26214
MOVT	R0, #16294
VMOV	S0, R0
BL	_HMC5883L_set_scale+0
;hmc5883l.c,25 :: 		}
L_end_HMC5883L_init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_init
_HMC5883L_read:
;hmc5883l.c,28 :: 		unsigned char HMC5883L_read(unsigned char reg)
; reg start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; reg end address is: 0 (R0)
; reg start address is: 16 (R4)
;hmc5883l.c,30 :: 		unsigned char val = 0;
;hmc5883l.c,32 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;hmc5883l.c,33 :: 		Soft_I2C_Write(HMC5883L_WRITE_ADDR);
MOVS	R0, #60
BL	_Soft_I2C_Write+0
;hmc5883l.c,34 :: 		Soft_I2C_Write(reg);
UXTB	R0, R4
; reg end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;hmc5883l.c,35 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;hmc5883l.c,36 :: 		Soft_I2C_Write(HMC5883L_READ_ADDR);
MOVS	R0, #61
BL	_Soft_I2C_Write+0
;hmc5883l.c,37 :: 		val = Soft_I2C_Read(0);
MOVS	R0, #0
BL	_Soft_I2C_Read+0
; val start address is: 8 (R2)
UXTB	R2, R0
;hmc5883l.c,38 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;hmc5883l.c,40 :: 		return(val);
UXTB	R0, R2
; val end address is: 8 (R2)
;hmc5883l.c,41 :: 		}
L_end_HMC5883L_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_read
_HMC5883L_write:
;hmc5883l.c,44 :: 		void HMC5883L_write(unsigned char reg_address, unsigned char value)
; value start address is: 4 (R1)
; reg_address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
UXTB	R5, R1
; value end address is: 4 (R1)
; reg_address end address is: 0 (R0)
; reg_address start address is: 16 (R4)
; value start address is: 20 (R5)
;hmc5883l.c,46 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;hmc5883l.c,47 :: 		Soft_I2C_Write(HMC5883L_WRITE_ADDR);
MOVS	R0, #60
BL	_Soft_I2C_Write+0
;hmc5883l.c,48 :: 		Soft_I2C_Write(reg_address);
UXTB	R0, R4
; reg_address end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;hmc5883l.c,49 :: 		Soft_I2C_Write(value);
UXTB	R0, R5
; value end address is: 20 (R5)
BL	_Soft_I2C_Write+0
;hmc5883l.c,50 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;hmc5883l.c,51 :: 		}
L_end_HMC5883L_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_write
_HMC5883L_read_data:
;hmc5883l.c,53 :: 		void HMC5883L_read_data()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;hmc5883l.c,55 :: 		unsigned char lsb = 0;
;hmc5883l.c,56 :: 		unsigned char msb = 0;
;hmc5883l.c,58 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;hmc5883l.c,59 :: 		Soft_I2C_Write(HMC5883L_WRITE_ADDR);
MOVS	R0, #60
BL	_Soft_I2C_Write+0
;hmc5883l.c,60 :: 		Soft_I2C_Write(X_MSB_Reg);
MOVS	R0, #3
BL	_Soft_I2C_Write+0
;hmc5883l.c,61 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;hmc5883l.c,62 :: 		Soft_I2C_Write(HMC5883L_READ_ADDR);
MOVS	R0, #61
BL	_Soft_I2C_Write+0
;hmc5883l.c,64 :: 		msb = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
; msb start address is: 20 (R5)
UXTB	R5, R0
;hmc5883l.c,65 :: 		lsb = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
;hmc5883l.c,66 :: 		X_axis = make_word(msb, lsb);
UXTB	R1, R0
UXTB	R0, R5
; msb end address is: 20 (R5)
BL	_make_word+0
MOVW	R1, #lo_addr(_X_axis+0)
MOVT	R1, #hi_addr(_X_axis+0)
STRH	R0, [R1, #0]
;hmc5883l.c,68 :: 		msb = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
; msb start address is: 20 (R5)
UXTB	R5, R0
;hmc5883l.c,69 :: 		lsb = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
;hmc5883l.c,70 :: 		Z_axis = make_word(msb, lsb);
UXTB	R1, R0
UXTB	R0, R5
; msb end address is: 20 (R5)
BL	_make_word+0
MOVW	R1, #lo_addr(_Z_axis+0)
MOVT	R1, #hi_addr(_Z_axis+0)
STRH	R0, [R1, #0]
;hmc5883l.c,72 :: 		msb = Soft_I2C_Read(1);
MOVS	R0, #1
BL	_Soft_I2C_Read+0
; msb start address is: 20 (R5)
UXTB	R5, R0
;hmc5883l.c,73 :: 		lsb = Soft_I2C_Read(0);
MOVS	R0, #0
BL	_Soft_I2C_Read+0
;hmc5883l.c,74 :: 		Y_axis = make_word(msb, lsb);
UXTB	R1, R0
UXTB	R0, R5
; msb end address is: 20 (R5)
BL	_make_word+0
MOVW	R1, #lo_addr(_Y_axis+0)
MOVT	R1, #hi_addr(_Y_axis+0)
STRH	R0, [R1, #0]
;hmc5883l.c,76 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;hmc5883l.c,77 :: 		}
L_end_HMC5883L_read_data:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_read_data
_HMC5883L_scale_axes:
;hmc5883l.c,80 :: 		void HMC5883L_scale_axes()
SUB	SP, SP, #4
;hmc5883l.c,82 :: 		X_axis *= m_scale;
MOVW	R1, #lo_addr(_X_axis+0)
MOVT	R1, #hi_addr(_X_axis+0)
LDRSH	R0, [R1, #0]
VMOV	S1, R0
VCVT.F32	#1, S1, S1
MOVW	R2, #lo_addr(_m_scale+0)
MOVT	R2, #hi_addr(_m_scale+0)
VLDR	#1, S0, [R2, #0]
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R0, S0
SXTH	R0, R0
STRH	R0, [R1, #0]
;hmc5883l.c,83 :: 		Z_axis *= m_scale;
MOVW	R1, #lo_addr(_Z_axis+0)
MOVT	R1, #hi_addr(_Z_axis+0)
LDRSH	R0, [R1, #0]
VMOV	S1, R0
VCVT.F32	#1, S1, S1
MOV	R0, R2
VLDR	#1, S0, [R0, #0]
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R0, S0
SXTH	R0, R0
STRH	R0, [R1, #0]
;hmc5883l.c,84 :: 		Y_Axis *= m_scale;
MOVW	R1, #lo_addr(_Y_axis+0)
MOVT	R1, #hi_addr(_Y_axis+0)
LDRSH	R0, [R1, #0]
VMOV	S1, R0
VCVT.F32	#1, S1, S1
MOV	R0, R2
VLDR	#1, S0, [R0, #0]
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R0, S0
SXTH	R0, R0
STRH	R0, [R1, #0]
;hmc5883l.c,85 :: 		}
L_end_HMC5883L_scale_axes:
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_scale_axes
_HMC5883L_set_scale:
;hmc5883l.c,88 :: 		void HMC5883L_set_scale(float gauss)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; gauss start address is: 0 (R0)
VMOV.F32	S1, S0
; gauss end address is: 0 (R0)
; gauss start address is: 4 (R1)
;hmc5883l.c,90 :: 		unsigned char value = 0;
; value start address is: 0 (R0)
MOVS	R0, #0
;hmc5883l.c,92 :: 		if(gauss == 0.88)
MOVW	R1, #18350
MOVT	R1, #16225
VMOV	S0, R1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale2
; gauss end address is: 4 (R1)
;hmc5883l.c,94 :: 		value = 0x00;
MOVS	R0, #0
;hmc5883l.c,95 :: 		m_scale = 0.73;
MOVW	R1, #57672
MOVT	R1, #16186
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,96 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale3
L_HMC5883L_set_scale2:
;hmc5883l.c,98 :: 		else if(gauss == 1.3)
; gauss start address is: 4 (R1)
MOVW	R1, #26214
MOVT	R1, #16294
VMOV	S0, R1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale4
; gauss end address is: 4 (R1)
;hmc5883l.c,100 :: 		value = 0x01;
MOVS	R0, #1
;hmc5883l.c,101 :: 		m_scale = 0.92;
MOVW	R1, #34079
MOVT	R1, #16235
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,102 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale5
L_HMC5883L_set_scale4:
;hmc5883l.c,104 :: 		else if(gauss == 1.9)
; gauss start address is: 4 (R1)
MOVW	R1, #13107
MOVT	R1, #16371
VMOV	S0, R1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale6
; gauss end address is: 4 (R1)
;hmc5883l.c,106 :: 		value = 0x02;
MOVS	R0, #2
;hmc5883l.c,107 :: 		m_scale = 1.22;
MOVW	R1, #10486
MOVT	R1, #16284
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,108 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale7
L_HMC5883L_set_scale6:
;hmc5883l.c,110 :: 		else if(gauss == 2.5)
; gauss start address is: 4 (R1)
VMOV.F32	S0, #2.5
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale8
; gauss end address is: 4 (R1)
;hmc5883l.c,112 :: 		value = 0x03;
MOVS	R0, #3
;hmc5883l.c,113 :: 		m_scale = 1.52;
MOVW	R1, #36700
MOVT	R1, #16322
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,114 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale9
L_HMC5883L_set_scale8:
;hmc5883l.c,116 :: 		else if(gauss == 4.0)
; gauss start address is: 4 (R1)
VMOV.F32	S0, #4
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale10
; gauss end address is: 4 (R1)
;hmc5883l.c,118 :: 		value = 0x04;
MOVS	R0, #4
;hmc5883l.c,119 :: 		m_scale = 2.27;
MOVW	R1, #18350
MOVT	R1, #16401
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,120 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale11
L_HMC5883L_set_scale10:
;hmc5883l.c,122 :: 		else if(gauss == 4.7)
; gauss start address is: 4 (R1)
MOVW	R1, #26214
MOVT	R1, #16534
VMOV	S0, R1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale12
; gauss end address is: 4 (R1)
;hmc5883l.c,124 :: 		value = 0x05;
MOVS	R0, #5
;hmc5883l.c,125 :: 		m_scale = 2.56;
MOVW	R1, #55050
MOVT	R1, #16419
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,126 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale13
L_HMC5883L_set_scale12:
;hmc5883l.c,128 :: 		else if(gauss == 5.6)
; gauss start address is: 4 (R1)
MOVW	R1, #13107
MOVT	R1, #16563
VMOV	S0, R1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_HMC5883L_set_scale14
; gauss end address is: 4 (R1)
;hmc5883l.c,130 :: 		value = 0x06;
MOVS	R0, #6
;hmc5883l.c,131 :: 		m_scale = 3.03;
MOVW	R1, #60293
MOVT	R1, #16449
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
;hmc5883l.c,132 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale15
L_HMC5883L_set_scale14:
;hmc5883l.c,134 :: 		else if(gauss == 8.1)
; gauss start address is: 4 (R1)
MOVW	R1, #39322
MOVT	R1, #16641
VMOV	S0, R1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L__HMC5883L_set_scale23
; gauss end address is: 4 (R1)
;hmc5883l.c,136 :: 		value = 0x07;
MOVS	R0, #7
;hmc5883l.c,137 :: 		m_scale = 4.35;
MOVW	R1, #13107
MOVT	R1, #16523
VMOV	S0, R1
MOVW	R1, #lo_addr(_m_scale+0)
MOVT	R1, #hi_addr(_m_scale+0)
VSTR	#1, S0, [R1, #0]
; value end address is: 0 (R0)
;hmc5883l.c,138 :: 		}
IT	AL
BAL	L_HMC5883L_set_scale16
L__HMC5883L_set_scale23:
;hmc5883l.c,134 :: 		else if(gauss == 8.1)
;hmc5883l.c,138 :: 		}
L_HMC5883L_set_scale16:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale15:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale13:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale11:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale9:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale7:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale5:
; value start address is: 0 (R0)
; value end address is: 0 (R0)
L_HMC5883L_set_scale3:
;hmc5883l.c,140 :: 		value <<= 5;
; value start address is: 0 (R0)
LSLS	R1, R0, #5
; value end address is: 0 (R0)
;hmc5883l.c,141 :: 		HMC5883L_write(Config_Reg_B, value);
UXTB	R1, R1
MOVS	R0, #1
BL	_HMC5883L_write+0
;hmc5883l.c,142 :: 		}
L_end_HMC5883L_set_scale:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_set_scale
_HMC5883L_heading:
;hmc5883l.c,145 :: 		signed long HMC5883L_heading()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;hmc5883l.c,147 :: 		float heading = 0.0;
;hmc5883l.c,149 :: 		HMC5883L_read_data();
BL	_HMC5883L_read_data+0
;hmc5883l.c,150 :: 		HMC5883L_scale_axes();
BL	_HMC5883L_scale_axes+0
;hmc5883l.c,151 :: 		heading = atan2(Y_axis, X_axis);
MOVW	R0, #lo_addr(_X_axis+0)
MOVT	R0, #hi_addr(_X_axis+0)
LDRSH	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
VMOV.F32	S1, S0
MOVW	R0, #lo_addr(_Y_axis+0)
MOVT	R0, #hi_addr(_Y_axis+0)
LDRSH	R0, [R0, #0]
VMOV	S0, R0
VCVT.F32	#1, S0, S0
BL	_atan2+0
;hmc5883l.c,152 :: 		heading += declination_angle;
MOVW	R0, #18036
MOVT	R0, #48900
VMOV	S1, R0
VADD.F32	S0, S0, S1
; heading start address is: 4 (R1)
VMOV.F32	S1, S0
;hmc5883l.c,154 :: 		if(heading < 0.0)
VCMPE.F32	S0, #0
VMRS	#60, FPSCR
IT	GE
BGE	L__HMC5883L_heading24
;hmc5883l.c,156 :: 		heading += (2.0 * PI);
MOVW	R0, #5767
MOVT	R0, #16585
VMOV	S0, R0
VADD.F32	S1, S1, S0
; heading end address is: 4 (R1)
;hmc5883l.c,157 :: 		}
IT	AL
BAL	L_HMC5883L_heading17
L__HMC5883L_heading24:
;hmc5883l.c,154 :: 		if(heading < 0.0)
;hmc5883l.c,157 :: 		}
L_HMC5883L_heading17:
;hmc5883l.c,159 :: 		if(heading > (2.0 * PI))
; heading start address is: 4 (R1)
MOVW	R0, #5767
MOVT	R0, #16585
VMOV	S0, R0
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LE
BLE	L__HMC5883L_heading25
;hmc5883l.c,161 :: 		heading -= (2.0 * PI);
MOVW	R0, #5767
MOVT	R0, #16585
VMOV	S0, R0
VSUB.F32	S1, S1, S0
; heading end address is: 4 (R1)
;hmc5883l.c,162 :: 		}
IT	AL
BAL	L_HMC5883L_heading18
L__HMC5883L_heading25:
;hmc5883l.c,159 :: 		if(heading > (2.0 * PI))
;hmc5883l.c,162 :: 		}
L_HMC5883L_heading18:
;hmc5883l.c,164 :: 		heading *= (180.0 / PI);
; heading start address is: 4 (R1)
MOVW	R0, #10054
MOVT	R0, #16997
VMOV	S0, R0
VMUL.F32	S0, S1, S0
; heading end address is: 4 (R1)
;hmc5883l.c,166 :: 		return heading;
VCVT	#1, .F32, S0, S0
VMOV	R0, S0
;hmc5883l.c,167 :: 		}
L_end_HMC5883L_heading:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _HMC5883L_heading
_main:
;main.c,31 :: 		void main() {
SUB	SP, SP, #4
;main.c,34 :: 		HMC5883L_Init();
BL	_HMC5883L_init+0
;main.c,35 :: 		while(1)
L_main19:
;main.c,37 :: 		h = HMC5883L_heading();
BL	_HMC5883L_heading+0
MOVW	R1, #lo_addr(_h+0)
MOVT	R1, #hi_addr(_h+0)
STR	R0, [R1, #0]
;main.c,39 :: 		delay_ms(100);
MOVW	R7, #11305
MOVT	R7, #10
NOP
NOP
L_main21:
SUBS	R7, R7, #1
BNE	L_main21
NOP
NOP
;main.c,40 :: 		};
IT	AL
BAL	L_main19
;main.c,42 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
