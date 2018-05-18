
_BMP085_Init:

;bmp085.c,71 :: 		void BMP085_Init()
;bmp085.c,74 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,75 :: 		BMP085_I2C_Wr( BMP085_ADDRESS );
	MOVLW       238
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,76 :: 		BMP085_I2C_Wr( BMP085_CAL_AC1 );
	MOVLW       170
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,77 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,78 :: 		BMP085_I2C_Wr( BMP085_ADDRESS | 1 );
	MOVLW       239
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,80 :: 		for( i=0; i < 10; i++)
	CLRF        BMP085_Init_i_L0+0 
L_BMP085_Init0:
	MOVLW       10
	SUBWF       BMP085_Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_BMP085_Init1
;bmp085.c,82 :: 		((int*)&Cal)[i] = (BMP085_I2C_Rd(1) << 8) + BMP085_I2C_Rd(1);
	MOVF        BMP085_Init_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _Cal+0
	ADDWF       R0, 0 
	MOVWF       FLOC__BMP085_Init+2 
	MOVLW       hi_addr(_Cal+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__BMP085_Init+3 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__BMP085_Init+1 
	CLRF        FLOC__BMP085_Init+0 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__BMP085_Init+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BMP085_Init+1, 0 
	ADDWFC      R1, 1 
	MOVFF       FLOC__BMP085_Init+2, FSR1
	MOVFF       FLOC__BMP085_Init+3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;bmp085.c,80 :: 		for( i=0; i < 10; i++)
	INCF        BMP085_Init_i_L0+0, 1 
;bmp085.c,84 :: 		}
	GOTO        L_BMP085_Init0
L_BMP085_Init1:
;bmp085.c,85 :: 		((int*)&Cal)[10] = (BMP085_I2C_Rd(1) << 8) + BMP085_I2C_Rd(0);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__BMP085_Init+1 
	CLRF        FLOC__BMP085_Init+0 
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVF        FLOC__BMP085_Init+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BMP085_Init+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _Cal+20 
	MOVF        R1, 0 
	MOVWF       _Cal+21 
;bmp085.c,86 :: 		BMP085_I2C_Stop();
	CALL        _I2C1_Stop+0, 0
;bmp085.c,87 :: 		}
L_end_BMP085_Init:
	RETURN      0
; end of _BMP085_Init

_BMP085_Read:

;bmp085.c,89 :: 		void BMP085_Read( char oversampling, BMP085 *Bar )
;bmp085.c,91 :: 		char cmd = 0x34;            //pressure oss=0 register
	MOVLW       52
	MOVWF       BMP085_Read_cmd_L0+0 
	CLRF        BMP085_Read_UT_L0+0 
	CLRF        BMP085_Read_UT_L0+1 
	CLRF        BMP085_Read_UT_L0+2 
	CLRF        BMP085_Read_UT_L0+3 
	CLRF        BMP085_Read_UP_L0+0 
	CLRF        BMP085_Read_UP_L0+1 
	CLRF        BMP085_Read_UP_L0+2 
	CLRF        BMP085_Read_UP_L0+3 
;bmp085.c,97 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,98 :: 		BMP085_I2C_Wr( BMP085_ADDRESS );
	MOVLW       238
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,99 :: 		BMP085_I2C_Wr( BMP085_CONTROL );
	MOVLW       244
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,100 :: 		BMP085_I2C_Wr( BMP085_READTEMPCMD );
	MOVLW       46
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,101 :: 		BMP085_I2C_Stop();
	CALL        _I2C1_Stop+0, 0
;bmp085.c,103 :: 		Delay_ms( 5 );
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_BMP085_Read3:
	DECFSZ      R13, 1, 1
	BRA         L_BMP085_Read3
	DECFSZ      R12, 1, 1
	BRA         L_BMP085_Read3
;bmp085.c,105 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,106 :: 		BMP085_I2C_Wr( BMP085_ADDRESS );
	MOVLW       238
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,107 :: 		BMP085_I2C_Wr( BMP085_TEMPDATA );
	MOVLW       246
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,108 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,109 :: 		BMP085_I2C_Wr( BMP085_ADDRESS | 1 );
	MOVLW       239
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,110 :: 		Hi(UT) = BMP085_I2C_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_UT_L0+1 
;bmp085.c,111 :: 		Lo(UT) = BMP085_I2C_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_UT_L0+0 
;bmp085.c,112 :: 		BMP085_I2C_Stop();
	CALL        _I2C1_Stop+0, 0
;bmp085.c,115 :: 		cmd.B6 = oversampling.B0;
	BTFSC       FARG_BMP085_Read_oversampling+0, 0 
	GOTO        L__BMP085_Read21
	BCF         BMP085_Read_cmd_L0+0, 6 
	GOTO        L__BMP085_Read22
L__BMP085_Read21:
	BSF         BMP085_Read_cmd_L0+0, 6 
L__BMP085_Read22:
;bmp085.c,116 :: 		cmd.B7 = oversampling.B1;
	BTFSC       FARG_BMP085_Read_oversampling+0, 1 
	GOTO        L__BMP085_Read23
	BCF         BMP085_Read_cmd_L0+0, 7 
	GOTO        L__BMP085_Read24
L__BMP085_Read23:
	BSF         BMP085_Read_cmd_L0+0, 7 
L__BMP085_Read24:
;bmp085.c,117 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,118 :: 		BMP085_I2C_Wr( BMP085_ADDRESS );
	MOVLW       238
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,119 :: 		BMP085_I2C_Wr( BMP085_CONTROL );
	MOVLW       244
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,120 :: 		BMP085_I2C_Wr( cmd );
	MOVF        BMP085_Read_cmd_L0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,121 :: 		BMP085_I2C_Stop();
	CALL        _I2C1_Stop+0, 0
;bmp085.c,123 :: 		switch(oversampling)
	GOTO        L_BMP085_Read4
;bmp085.c,125 :: 		case 0: Delay_ms(5); break;    //3.3.1 de vermiþ bunlarý
L_BMP085_Read6:
	MOVLW       78
	MOVWF       R12, 0
	MOVLW       235
	MOVWF       R13, 0
L_BMP085_Read7:
	DECFSZ      R13, 1, 1
	BRA         L_BMP085_Read7
	DECFSZ      R12, 1, 1
	BRA         L_BMP085_Read7
	GOTO        L_BMP085_Read5
;bmp085.c,126 :: 		case 1: Delay_ms(8); break;
L_BMP085_Read8:
	MOVLW       125
	MOVWF       R12, 0
	MOVLW       171
	MOVWF       R13, 0
L_BMP085_Read9:
	DECFSZ      R13, 1, 1
	BRA         L_BMP085_Read9
	DECFSZ      R12, 1, 1
	BRA         L_BMP085_Read9
	NOP
	NOP
	GOTO        L_BMP085_Read5
;bmp085.c,127 :: 		case 2: Delay_ms(14); break;
L_BMP085_Read10:
	MOVLW       219
	MOVWF       R12, 0
	MOVLW       45
	MOVWF       R13, 0
L_BMP085_Read11:
	DECFSZ      R13, 1, 1
	BRA         L_BMP085_Read11
	DECFSZ      R12, 1, 1
	BRA         L_BMP085_Read11
	GOTO        L_BMP085_Read5
;bmp085.c,128 :: 		case 3: Delay_ms(26); break;
L_BMP085_Read12:
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       46
	MOVWF       R13, 0
L_BMP085_Read13:
	DECFSZ      R13, 1, 1
	BRA         L_BMP085_Read13
	DECFSZ      R12, 1, 1
	BRA         L_BMP085_Read13
	DECFSZ      R11, 1, 1
	BRA         L_BMP085_Read13
	NOP
	GOTO        L_BMP085_Read5
;bmp085.c,129 :: 		}
L_BMP085_Read4:
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_BMP085_Read6
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_BMP085_Read8
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_BMP085_Read10
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_BMP085_Read12
L_BMP085_Read5:
;bmp085.c,133 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,134 :: 		BMP085_I2C_Wr( BMP085_ADDRESS );
	MOVLW       238
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,135 :: 		BMP085_I2C_Wr( BMP085_PRESSUREDATA );
	MOVLW       246
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,136 :: 		BMP085_I2C_Start();
	CALL        _I2C1_Start+0, 0
;bmp085.c,137 :: 		BMP085_I2C_Wr( BMP085_ADDRESS | 1 );
	MOVLW       239
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;bmp085.c,138 :: 		Higher(UP) = BMP085_I2C_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_UP_L0+2 
;bmp085.c,139 :: 		Hi(UP) = BMP085_I2C_Rd(1);
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_UP_L0+1 
;bmp085.c,140 :: 		Lo(UP) = BMP085_I2C_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_UP_L0+0 
;bmp085.c,141 :: 		BMP085_I2C_Stop();
	CALL        _I2C1_Stop+0, 0
;bmp085.c,142 :: 		Highest(UP) = 0;
	CLRF        BMP085_Read_UP_L0+3 
;bmp085.c,143 :: 		UP >>= ( 8 - oversampling );
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
L__BMP085_Read25:
	BZ          L__BMP085_Read26
	RRCF        BMP085_Read_UP_L0+3, 1 
	RRCF        BMP085_Read_UP_L0+2, 1 
	RRCF        BMP085_Read_UP_L0+1, 1 
	RRCF        BMP085_Read_UP_L0+0, 1 
	BCF         BMP085_Read_UP_L0+3, 7 
	BTFSC       BMP085_Read_UP_L0+3, 6 
	BSF         BMP085_Read_UP_L0+3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read25
L__BMP085_Read26:
;bmp085.c,146 :: 		X1 = ( UT - Cal.AC6 );
	MOVF        BMP085_Read_UT_L0+0, 0 
	MOVWF       R0 
	MOVF        BMP085_Read_UT_L0+1, 0 
	MOVWF       R1 
	MOVF        BMP085_Read_UT_L0+2, 0 
	MOVWF       R2 
	MOVF        BMP085_Read_UT_L0+3, 0 
	MOVWF       R3 
	MOVF        _Cal+10, 0 
	SUBWF       R0, 1 
	MOVF        _Cal+11, 0 
	SUBWFB      R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
;bmp085.c,147 :: 		X1 *= Cal.AC5;
	MOVF        _Cal+8, 0 
	MOVWF       R4 
	MOVF        _Cal+9, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,148 :: 		X1 >>= 15;
	MOVLW       15
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC__BMP085_Read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__BMP085_Read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__BMP085_Read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__BMP085_Read+3 
	MOVF        R4, 0 
L__BMP085_Read27:
	BZ          L__BMP085_Read28
	RRCF        FLOC__BMP085_Read+3, 1 
	RRCF        FLOC__BMP085_Read+2, 1 
	RRCF        FLOC__BMP085_Read+1, 1 
	RRCF        FLOC__BMP085_Read+0, 1 
	BCF         FLOC__BMP085_Read+3, 7 
	BTFSC       FLOC__BMP085_Read+3, 6 
	BSF         FLOC__BMP085_Read+3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read27
L__BMP085_Read28:
;bmp085.c,150 :: 		X2 = ((long)Cal.MC << 11);
	MOVF        _Cal+18, 0 
	MOVWF       R1 
	MOVF        _Cal+19, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       _Cal+19, 7 
	MOVLW       255
	MOVWF       R3 
	MOVWF       R4 
	MOVLW       11
	MOVWF       R0 
	MOVF        R1, 0 
	MOVWF       R8 
	MOVF        R2, 0 
	MOVWF       R9 
	MOVF        R3, 0 
	MOVWF       R10 
	MOVF        R4, 0 
	MOVWF       R11 
	MOVF        R0, 0 
L__BMP085_Read29:
	BZ          L__BMP085_Read30
	RLCF        R8, 1 
	BCF         R8, 0 
	RLCF        R9, 1 
	RLCF        R10, 1 
	RLCF        R11, 1 
	ADDLW       255
	GOTO        L__BMP085_Read29
L__BMP085_Read30:
;bmp085.c,151 :: 		X2 /= (X1 + Cal.MD);
	MOVF        _Cal+20, 0 
	ADDWF       FLOC__BMP085_Read+0, 0 
	MOVWF       R4 
	MOVF        _Cal+21, 0 
	ADDWFC      FLOC__BMP085_Read+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       _Cal+21, 7 
	MOVLW       255
	ADDWFC      FLOC__BMP085_Read+2, 0 
	MOVWF       R6 
	MOVLW       0
	BTFSC       _Cal+21, 7 
	MOVLW       255
	ADDWFC      FLOC__BMP085_Read+3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
;bmp085.c,153 :: 		_B5 = X1 + X2;
	MOVF        FLOC__BMP085_Read+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BMP085_Read+1, 0 
	ADDWFC      R1, 1 
	MOVF        FLOC__BMP085_Read+2, 0 
	ADDWFC      R2, 1 
	MOVF        FLOC__BMP085_Read+3, 0 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       BMP085_Read__B5_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read__B5_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read__B5_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read__B5_L0+3 
;bmp085.c,155 :: 		Bar->Temperatura = ( (_B5 + 8) >> 4 ) / 10;
	MOVLW       8
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BMP085_Read31:
	BZ          L__BMP085_Read32
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read31
L__BMP085_Read32:
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	CALL        _longint2double+0, 0
	MOVFF       FARG_BMP085_Read_Bar+0, FSR1
	MOVFF       FARG_BMP085_Read_Bar+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;bmp085.c,158 :: 		_B6 = _B5 - 4000;
	MOVF        BMP085_Read__B5_L0+0, 0 
	MOVWF       R0 
	MOVF        BMP085_Read__B5_L0+1, 0 
	MOVWF       R1 
	MOVF        BMP085_Read__B5_L0+2, 0 
	MOVWF       R2 
	MOVF        BMP085_Read__B5_L0+3, 0 
	MOVWF       R3 
	MOVLW       160
	SUBWF       R0, 1 
	MOVLW       15
	SUBWFB      R1, 1 
	MOVLW       0
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	MOVWF       BMP085_Read__B6_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read__B6_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read__B6_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read__B6_L0+3 
;bmp085.c,160 :: 		X1 = pow(_B6, 2);
	CALL        _longint2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_pow_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_pow_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_pow_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_pow_x+3 
	MOVLW       0
	MOVWF       FARG_pow_y+0 
	MOVLW       0
	MOVWF       FARG_pow_y+1 
	MOVLW       0
	MOVWF       FARG_pow_y+2 
	MOVLW       128
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
	CALL        _double2longint+0, 0
;bmp085.c,161 :: 		X1 >>= 12;
	MOVLW       12
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L__BMP085_Read33:
	BZ          L__BMP085_Read34
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L__BMP085_Read33
L__BMP085_Read34:
;bmp085.c,162 :: 		X1 *= (long)Cal.mB2;
	MOVF        _Cal+14, 0 
	MOVWF       R0 
	MOVF        _Cal+15, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _Cal+15, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,163 :: 		X1 >>= 11;
	MOVLW       11
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC__BMP085_Read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__BMP085_Read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__BMP085_Read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__BMP085_Read+3 
	MOVF        R4, 0 
L__BMP085_Read35:
	BZ          L__BMP085_Read36
	RRCF        FLOC__BMP085_Read+3, 1 
	RRCF        FLOC__BMP085_Read+2, 1 
	RRCF        FLOC__BMP085_Read+1, 1 
	RRCF        FLOC__BMP085_Read+0, 1 
	BCF         FLOC__BMP085_Read+3, 7 
	BTFSC       FLOC__BMP085_Read+3, 6 
	BSF         FLOC__BMP085_Read+3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read35
L__BMP085_Read36:
;bmp085.c,165 :: 		X2 = ((long)Cal.AC2 * _B6);
	MOVF        _Cal+2, 0 
	MOVWF       R0 
	MOVF        _Cal+3, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _Cal+3, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        BMP085_Read__B6_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read__B6_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read__B6_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read__B6_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,166 :: 		X2 >>= 11;
	MOVLW       11
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L__BMP085_Read37:
	BZ          L__BMP085_Read38
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L__BMP085_Read37
L__BMP085_Read38:
;bmp085.c,168 :: 		X3 = X1 + X2;
	MOVF        R4, 0 
	ADDWF       FLOC__BMP085_Read+0, 0 
	MOVWF       R9 
	MOVF        R5, 0 
	ADDWFC      FLOC__BMP085_Read+1, 0 
	MOVWF       R10 
	MOVF        R6, 0 
	ADDWFC      FLOC__BMP085_Read+2, 0 
	MOVWF       R11 
	MOVF        R7, 0 
	ADDWFC      FLOC__BMP085_Read+3, 0 
	MOVWF       R12 
;bmp085.c,170 :: 		_B3 = (long)Cal.AC1 * 4;
	MOVF        _Cal+0, 0 
	MOVWF       R5 
	MOVF        _Cal+1, 0 
	MOVWF       R6 
	MOVLW       0
	BTFSC       _Cal+1, 7 
	MOVLW       255
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
;bmp085.c,171 :: 		_B3 += X3;
	MOVF        R9, 0 
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVF        R10, 0 
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVF        R11, 0 
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVF        R12, 0 
	ADDWFC      R3, 0 
	MOVWF       R8 
;bmp085.c,172 :: 		_B3 <<= oversampling;
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BMP085_Read39:
	BZ          L__BMP085_Read40
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__BMP085_Read39
L__BMP085_Read40:
;bmp085.c,173 :: 		_B3 += 2;
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R7 
;bmp085.c,174 :: 		_B3 >>= 2;
	MOVF        R4, 0 
	MOVWF       FLOC__BMP085_Read+4 
	MOVF        R5, 0 
	MOVWF       FLOC__BMP085_Read+5 
	MOVF        R6, 0 
	MOVWF       FLOC__BMP085_Read+6 
	MOVF        R7, 0 
	MOVWF       FLOC__BMP085_Read+7 
	RRCF        FLOC__BMP085_Read+7, 1 
	RRCF        FLOC__BMP085_Read+6, 1 
	RRCF        FLOC__BMP085_Read+5, 1 
	RRCF        FLOC__BMP085_Read+4, 1 
	BCF         FLOC__BMP085_Read+7, 7 
	BTFSC       FLOC__BMP085_Read+7, 6 
	BSF         FLOC__BMP085_Read+7, 7 
	RRCF        FLOC__BMP085_Read+7, 1 
	RRCF        FLOC__BMP085_Read+6, 1 
	RRCF        FLOC__BMP085_Read+5, 1 
	RRCF        FLOC__BMP085_Read+4, 1 
	BCF         FLOC__BMP085_Read+7, 7 
	BTFSC       FLOC__BMP085_Read+7, 6 
	BSF         FLOC__BMP085_Read+7, 7 
;bmp085.c,176 :: 		X1 = (Cal.AC3 * _B6);
	MOVF        _Cal+4, 0 
	MOVWF       R0 
	MOVF        _Cal+5, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _Cal+5, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        BMP085_Read__B6_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read__B6_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read__B6_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read__B6_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,177 :: 		X1 >>= 13;
	MOVLW       13
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC__BMP085_Read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__BMP085_Read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__BMP085_Read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__BMP085_Read+3 
	MOVF        R4, 0 
L__BMP085_Read41:
	BZ          L__BMP085_Read42
	RRCF        FLOC__BMP085_Read+3, 1 
	RRCF        FLOC__BMP085_Read+2, 1 
	RRCF        FLOC__BMP085_Read+1, 1 
	RRCF        FLOC__BMP085_Read+0, 1 
	BCF         FLOC__BMP085_Read+3, 7 
	BTFSC       FLOC__BMP085_Read+3, 6 
	BSF         FLOC__BMP085_Read+3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read41
L__BMP085_Read42:
;bmp085.c,179 :: 		X2 = (_B6 * _B6);
	MOVF        BMP085_Read__B6_L0+0, 0 
	MOVWF       R0 
	MOVF        BMP085_Read__B6_L0+1, 0 
	MOVWF       R1 
	MOVF        BMP085_Read__B6_L0+2, 0 
	MOVWF       R2 
	MOVF        BMP085_Read__B6_L0+3, 0 
	MOVWF       R3 
	MOVF        BMP085_Read__B6_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read__B6_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read__B6_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read__B6_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,180 :: 		X2 >>= 12;
	MOVLW       12
	MOVWF       R8 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        R8, 0 
L__BMP085_Read43:
	BZ          L__BMP085_Read44
	RRCF        R7, 1 
	RRCF        R6, 1 
	RRCF        R5, 1 
	RRCF        R4, 1 
	BCF         R7, 7 
	BTFSC       R7, 6 
	BSF         R7, 7 
	ADDLW       255
	GOTO        L__BMP085_Read43
L__BMP085_Read44:
;bmp085.c,181 :: 		X2 *= Cal.mB1;
	MOVF        _Cal+12, 0 
	MOVWF       R0 
	MOVF        _Cal+13, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _Cal+13, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,182 :: 		X2 >>= 8;
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	BTFSC       R3, 7 
	MOVLW       255
	MOVWF       R8 
;bmp085.c,183 :: 		X2 >>= 8;
	MOVF        R6, 0 
	MOVWF       R0 
	MOVF        R7, 0 
	MOVWF       R1 
	MOVF        R8, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       R8, 7 
	MOVLW       255
	MOVWF       R3 
;bmp085.c,185 :: 		X3 = ((X1 + X2) + 2 );
	MOVF        FLOC__BMP085_Read+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BMP085_Read+1, 0 
	ADDWFC      R1, 1 
	MOVF        FLOC__BMP085_Read+2, 0 
	ADDWFC      R2, 1 
	MOVF        FLOC__BMP085_Read+3, 0 
	ADDWFC      R3, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R8 
;bmp085.c,186 :: 		X3 >>= 2;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
;bmp085.c,188 :: 		_B4 = Cal.AC4;
	MOVF        _Cal+6, 0 
	MOVWF       BMP085_Read__B4_L0+0 
	MOVF        _Cal+7, 0 
	MOVWF       BMP085_Read__B4_L0+1 
	MOVLW       0
	MOVWF       BMP085_Read__B4_L0+2 
	MOVWF       BMP085_Read__B4_L0+3 
;bmp085.c,189 :: 		_B4 *= (unsigned long)(X3 + 32768);
	MOVLW       0
	ADDWF       R0, 1 
	MOVLW       128
	ADDWFC      R1, 1 
	MOVLW       0
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        BMP085_Read__B4_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read__B4_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read__B4_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read__B4_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read__B4_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read__B4_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read__B4_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read__B4_L0+3 
;bmp085.c,190 :: 		_B4 >>= 15;
	MOVLW       15
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       BMP085_Read__B4_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read__B4_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read__B4_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read__B4_L0+3 
	MOVF        R4, 0 
L__BMP085_Read45:
	BZ          L__BMP085_Read46
	RRCF        BMP085_Read__B4_L0+3, 1 
	RRCF        BMP085_Read__B4_L0+2, 1 
	RRCF        BMP085_Read__B4_L0+1, 1 
	RRCF        BMP085_Read__B4_L0+0, 1 
	BCF         BMP085_Read__B4_L0+3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read45
L__BMP085_Read46:
;bmp085.c,192 :: 		_B7 = (unsigned long)(UP - _B3);
	MOVF        BMP085_Read_UP_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read_UP_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read_UP_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read_UP_L0+3, 0 
	MOVWF       R7 
	MOVF        FLOC__BMP085_Read+4, 0 
	SUBWF       R4, 1 
	MOVF        FLOC__BMP085_Read+5, 0 
	SUBWFB      R5, 1 
	MOVF        FLOC__BMP085_Read+6, 0 
	SUBWFB      R6, 1 
	MOVF        FLOC__BMP085_Read+7, 0 
	SUBWFB      R7, 1 
	MOVF        R4, 0 
	MOVWF       BMP085_Read__B7_L0+0 
	MOVF        R5, 0 
	MOVWF       BMP085_Read__B7_L0+1 
	MOVF        R6, 0 
	MOVWF       BMP085_Read__B7_L0+2 
	MOVF        R7, 0 
	MOVWF       BMP085_Read__B7_L0+3 
;bmp085.c,193 :: 		_B7 *= (unsigned long)(50000 >> oversampling);
	MOVF        FARG_BMP085_Read_oversampling+0, 0 
	MOVWF       R2 
	MOVLW       80
	MOVWF       R0 
	MOVLW       195
	MOVWF       R1 
	MOVF        R2, 0 
L__BMP085_Read47:
	BZ          L__BMP085_Read48
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	ADDLW       255
	GOTO        L__BMP085_Read47
L__BMP085_Read48:
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read__B7_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read__B7_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read__B7_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read__B7_L0+3 
;bmp085.c,195 :: 		if( _B7 < 0x80000000 )
	MOVLW       128
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BMP085_Read49
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BMP085_Read49
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BMP085_Read49
	MOVLW       0
	SUBWF       R0, 0 
L__BMP085_Read49:
	BTFSC       STATUS+0, 0 
	GOTO        L_BMP085_Read14
;bmp085.c,197 :: 		pp = ((_B7 * 2) / _B4);
	MOVF        BMP085_Read__B7_L0+0, 0 
	MOVWF       R0 
	MOVF        BMP085_Read__B7_L0+1, 0 
	MOVWF       R1 
	MOVF        BMP085_Read__B7_L0+2, 0 
	MOVWF       R2 
	MOVF        BMP085_Read__B7_L0+3, 0 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVF        BMP085_Read__B4_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read__B4_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read__B4_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read__B4_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_pp_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read_pp_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read_pp_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read_pp_L0+3 
;bmp085.c,199 :: 		}
	GOTO        L_BMP085_Read15
L_BMP085_Read14:
;bmp085.c,202 :: 		pp = ((_B7 / _B4) * 2);
	MOVF        BMP085_Read__B4_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read__B4_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read__B4_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read__B4_L0+3, 0 
	MOVWF       R7 
	MOVF        BMP085_Read__B7_L0+0, 0 
	MOVWF       R0 
	MOVF        BMP085_Read__B7_L0+1, 0 
	MOVWF       R1 
	MOVF        BMP085_Read__B7_L0+2, 0 
	MOVWF       R2 
	MOVF        BMP085_Read__B7_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       BMP085_Read_pp_L0+0 
	MOVF        R1, 0 
	MOVWF       BMP085_Read_pp_L0+1 
	MOVF        R2, 0 
	MOVWF       BMP085_Read_pp_L0+2 
	MOVF        R3, 0 
	MOVWF       BMP085_Read_pp_L0+3 
	RLCF        BMP085_Read_pp_L0+0, 1 
	BCF         BMP085_Read_pp_L0+0, 0 
	RLCF        BMP085_Read_pp_L0+1, 1 
	RLCF        BMP085_Read_pp_L0+2, 1 
	RLCF        BMP085_Read_pp_L0+3, 1 
;bmp085.c,203 :: 		}
L_BMP085_Read15:
;bmp085.c,205 :: 		X1 = pow((pp >> 8), 2);
	MOVF        BMP085_Read_pp_L0+1, 0 
	MOVWF       R0 
	MOVF        BMP085_Read_pp_L0+2, 0 
	MOVWF       R1 
	MOVF        BMP085_Read_pp_L0+3, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       BMP085_Read_pp_L0+3, 7 
	MOVLW       255
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_pow_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_pow_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_pow_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_pow_x+3 
	MOVLW       0
	MOVWF       FARG_pow_y+0 
	MOVLW       0
	MOVWF       FARG_pow_y+1 
	MOVLW       0
	MOVWF       FARG_pow_y+2 
	MOVLW       128
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
	CALL        _double2longint+0, 0
;bmp085.c,206 :: 		X1 *= 1519;
	MOVLW       239
	MOVWF       R4 
	MOVLW       5
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,207 :: 		X1 >>= 15;
	MOVLW       15
	MOVWF       R4 
	MOVF        R0, 0 
	MOVWF       FLOC__BMP085_Read+4 
	MOVF        R1, 0 
	MOVWF       FLOC__BMP085_Read+5 
	MOVF        R2, 0 
	MOVWF       FLOC__BMP085_Read+6 
	MOVF        R3, 0 
	MOVWF       FLOC__BMP085_Read+7 
	MOVF        R4, 0 
L__BMP085_Read50:
	BZ          L__BMP085_Read51
	RRCF        FLOC__BMP085_Read+7, 1 
	RRCF        FLOC__BMP085_Read+6, 1 
	RRCF        FLOC__BMP085_Read+5, 1 
	RRCF        FLOC__BMP085_Read+4, 1 
	BCF         FLOC__BMP085_Read+7, 7 
	BTFSC       FLOC__BMP085_Read+7, 6 
	BSF         FLOC__BMP085_Read+7, 7 
	ADDLW       255
	GOTO        L__BMP085_Read50
L__BMP085_Read51:
;bmp085.c,209 :: 		X2 = (-7357 * pp);
	MOVLW       67
	MOVWF       R0 
	MOVLW       227
	MOVWF       R1 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        BMP085_Read_pp_L0+0, 0 
	MOVWF       R4 
	MOVF        BMP085_Read_pp_L0+1, 0 
	MOVWF       R5 
	MOVF        BMP085_Read_pp_L0+2, 0 
	MOVWF       R6 
	MOVF        BMP085_Read_pp_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
;bmp085.c,210 :: 		X2 >>= 8;
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	BTFSC       R3, 7 
	MOVLW       255
	MOVWF       R8 
;bmp085.c,211 :: 		X2 >>= 8;
	MOVF        R6, 0 
	MOVWF       R0 
	MOVF        R7, 0 
	MOVWF       R1 
	MOVF        R8, 0 
	MOVWF       R2 
	MOVLW       0
	BTFSC       R8, 7 
	MOVLW       255
	MOVWF       R3 
;bmp085.c,213 :: 		Bar->Pressao = pp + ( (X1 + X2 + 3791) >> 4);
	MOVLW       4
	ADDWF       FARG_BMP085_Read_Bar+0, 0 
	MOVWF       FLOC__BMP085_Read+0 
	MOVLW       0
	ADDWFC      FARG_BMP085_Read_Bar+1, 0 
	MOVWF       FLOC__BMP085_Read+1 
	MOVF        FLOC__BMP085_Read+4, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__BMP085_Read+5, 0 
	ADDWFC      R1, 1 
	MOVF        FLOC__BMP085_Read+6, 0 
	ADDWFC      R2, 1 
	MOVF        FLOC__BMP085_Read+7, 0 
	ADDWFC      R3, 1 
	MOVLW       207
	ADDWF       R0, 0 
	MOVWF       R5 
	MOVLW       14
	ADDWFC      R1, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R7 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R8 
	MOVLW       4
	MOVWF       R4 
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
	MOVF        R7, 0 
	MOVWF       R2 
	MOVF        R8, 0 
	MOVWF       R3 
	MOVF        R4, 0 
L__BMP085_Read52:
	BZ          L__BMP085_Read53
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	ADDLW       255
	GOTO        L__BMP085_Read52
L__BMP085_Read53:
	MOVF        BMP085_Read_pp_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        BMP085_Read_pp_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        BMP085_Read_pp_L0+2, 0 
	ADDWFC      R2, 1 
	MOVF        BMP085_Read_pp_L0+3, 0 
	ADDWFC      R3, 1 
	CALL        _longint2double+0, 0
	MOVFF       FLOC__BMP085_Read+0, FSR1
	MOVFF       FLOC__BMP085_Read+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;bmp085.c,216 :: 		Bar->Altitude = 1 - pow( (Bar->Pressao / 101035), 0.190295 );
	MOVLW       8
	ADDWF       FARG_BMP085_Read_Bar+0, 0 
	MOVWF       FLOC__BMP085_Read+0 
	MOVLW       0
	ADDWFC      FARG_BMP085_Read_Bar+1, 0 
	MOVWF       FLOC__BMP085_Read+1 
	MOVLW       4
	ADDWF       FARG_BMP085_Read_Bar+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_BMP085_Read_Bar+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R4 
	MOVLW       85
	MOVWF       R5 
	MOVLW       69
	MOVWF       R6 
	MOVLW       143
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_pow_x+0 
	MOVF        R1, 0 
	MOVWF       FARG_pow_x+1 
	MOVF        R2, 0 
	MOVWF       FARG_pow_x+2 
	MOVF        R3, 0 
	MOVWF       FARG_pow_x+3 
	MOVLW       177
	MOVWF       FARG_pow_y+0 
	MOVLW       220
	MOVWF       FARG_pow_y+1 
	MOVLW       66
	MOVWF       FARG_pow_y+2 
	MOVLW       124
	MOVWF       FARG_pow_y+3 
	CALL        _pow+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVFF       FLOC__BMP085_Read+0, FSR1
	MOVFF       FLOC__BMP085_Read+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;bmp085.c,217 :: 		Bar->Altitude *= 44330;
	MOVLW       8
	ADDWF       FARG_BMP085_Read_Bar+0, 0 
	MOVWF       FLOC__BMP085_Read+0 
	MOVLW       0
	ADDWFC      FARG_BMP085_Read_Bar+1, 0 
	MOVWF       FLOC__BMP085_Read+1 
	MOVFF       FLOC__BMP085_Read+0, FSR0
	MOVFF       FLOC__BMP085_Read+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       42
	MOVWF       R5 
	MOVLW       45
	MOVWF       R6 
	MOVLW       142
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVFF       FLOC__BMP085_Read+0, FSR1
	MOVFF       FLOC__BMP085_Read+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;bmp085.c,218 :: 		return;
;bmp085.c,219 :: 		}
L_end_BMP085_Read:
	RETURN      0
; end of _BMP085_Read

_main:

;pressure_sensor_bmp085.c,32 :: 		void main()
;pressure_sensor_bmp085.c,34 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;pressure_sensor_bmp085.c,36 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;pressure_sensor_bmp085.c,37 :: 		Lcd_Cmd( _LCD_CLEAR );
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;pressure_sensor_bmp085.c,39 :: 		I2C1_Init(100000);
	MOVLW       120
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;pressure_sensor_bmp085.c,40 :: 		BMP085_Init();
	CALL        _BMP085_Init+0, 0
;pressure_sensor_bmp085.c,42 :: 		while(1)
L_main16:
;pressure_sensor_bmp085.c,44 :: 		BMP085_Read( BMP085_ULTRALOWPOWER, &Bar );
	CLRF        FARG_BMP085_Read_oversampling+0 
	MOVLW       _Bar+0
	MOVWF       FARG_BMP085_Read_Bar+0 
	MOVLW       hi_addr(_Bar+0)
	MOVWF       FARG_BMP085_Read_Bar+1 
	CALL        _BMP085_Read+0, 0
;pressure_sensor_bmp085.c,46 :: 		LongWordToStr( Bar.Pressao, text );
	MOVF        _Bar+4, 0 
	MOVWF       R0 
	MOVF        _Bar+5, 0 
	MOVWF       R1 
	MOVF        _Bar+6, 0 
	MOVWF       R2 
	MOVF        _Bar+7, 0 
	MOVWF       R3 
	CALL        _double2longword+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_LongWordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_LongWordToStr_input+1 
	MOVF        R2, 0 
	MOVWF       FARG_LongWordToStr_input+2 
	MOVF        R3, 0 
	MOVWF       FARG_LongWordToStr_input+3 
	MOVLW       _text+0
	MOVWF       FARG_LongWordToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_LongWordToStr_output+1 
	CALL        _LongWordToStr+0, 0
;pressure_sensor_bmp085.c,47 :: 		LTrim( text );
	MOVLW       _text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;pressure_sensor_bmp085.c,48 :: 		Lcd_Out( 1, 1, "P: " );
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_pressure_sensor_bmp085+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_pressure_sensor_bmp085+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;pressure_sensor_bmp085.c,49 :: 		Lcd_Out_CP( text );
	MOVLW       _text+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;pressure_sensor_bmp085.c,50 :: 		Lcd_Out_CP( "Pa" );
	MOVLW       ?lstr2_pressure_sensor_bmp085+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr2_pressure_sensor_bmp085+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;pressure_sensor_bmp085.c,52 :: 		IntToStr( Bar.Altitude, text );
	MOVF        _Bar+8, 0 
	MOVWF       R0 
	MOVF        _Bar+9, 0 
	MOVWF       R1 
	MOVF        _Bar+10, 0 
	MOVWF       R2 
	MOVF        _Bar+11, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _text+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;pressure_sensor_bmp085.c,53 :: 		LTrim( text );
	MOVLW       _text+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;pressure_sensor_bmp085.c,54 :: 		Lcd_Out( 2, 1, "A: " );
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_pressure_sensor_bmp085+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_pressure_sensor_bmp085+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;pressure_sensor_bmp085.c,55 :: 		Lcd_Out_CP( text );
	MOVLW       _text+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;pressure_sensor_bmp085.c,56 :: 		Lcd_Out_CP( "m" );
	MOVLW       ?lstr4_pressure_sensor_bmp085+0
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       hi_addr(?lstr4_pressure_sensor_bmp085+0)
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;pressure_sensor_bmp085.c,58 :: 		Delay_ms( 500 );
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_main18:
	DECFSZ      R13, 1, 1
	BRA         L_main18
	DECFSZ      R12, 1, 1
	BRA         L_main18
	DECFSZ      R11, 1, 1
	BRA         L_main18
	NOP
;pressure_sensor_bmp085.c,59 :: 		}
	GOTO        L_main16
;pressure_sensor_bmp085.c,60 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
