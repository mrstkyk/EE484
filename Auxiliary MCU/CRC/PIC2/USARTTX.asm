
_interrupt:

;USARTTX.c,6 :: 		void interrupt()
;USARTTX.c,8 :: 		if(PIR1.RCIF)
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt0
;USARTTX.c,10 :: 		PIR1.RCIF=0;   //LED 1
	BCF         PIR1+0, 5 
;USARTTX.c,12 :: 		UART1_Read_Text(gelen,"OK", 30);    // reads text until 'OK' is found
	MOVLW       _gelen+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_gelen+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr1_USARTTX+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr1_USARTTX+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       30
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;USARTTX.c,13 :: 		if(gelen[0]==crc_data[0])
	MOVF        _gelen+0, 0 
	XORWF       _crc_data+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;USARTTX.c,15 :: 		PORTC.F0=1;
	BSF         PORTC+0, 0 
;USARTTX.c,16 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_interrupt2:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt2
	DECFSZ      R12, 1, 1
	BRA         L_interrupt2
	DECFSZ      R11, 1, 1
	BRA         L_interrupt2
	NOP
;USARTTX.c,17 :: 		PORTC.F0=0;                          //LED 0
	BCF         PORTC+0, 0 
;USARTTX.c,19 :: 		}
L_interrupt1:
;USARTTX.c,24 :: 		PIR1.RCIF=0;                         //FLAG TEMÝZLENDÝ
	BCF         PIR1+0, 5 
;USARTTX.c,26 :: 		}
L_interrupt0:
;USARTTX.c,27 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt

_main:

;USARTTX.c,31 :: 		void main()
;USARTTX.c,32 :: 		{ unsigned int k=255,l=5;
;USARTTX.c,33 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;USARTTX.c,34 :: 		PORTB = 0;
	CLRF        PORTB+0 
;USARTTX.c,35 :: 		TRISC.F0=0;
	BCF         TRISC+0, 0 
;USARTTX.c,36 :: 		PORTC.F0=0;
	BCF         PORTC+0, 0 
;USARTTX.c,40 :: 		UART1_Init(9600);    // UART 9600 Baudrate ile baslatýldý.
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USARTTX.c,41 :: 		INTCON.GIE = 1;      // GLOBAL INTERRUPT ENABLE
	BSF         INTCON+0, 7 
;USARTTX.c,42 :: 		PIE1.RCIE = 1;       // RECIEVE INTERRUPT ENABLE
	BSF         PIE1+0, 5 
;USARTTX.c,43 :: 		INTCON.PEIE = 1;     // peripheral intterrupt
	BSF         INTCON+0, 6 
;USARTTX.c,44 :: 		PIR1.RCIF=0;         // RX FLAG BIT
	BCF         PIR1+0, 5 
;USARTTX.c,45 :: 		RCSTA.CREN=1;
	BSF         RCSTA+0, 4 
;USARTTX.c,47 :: 		while (1)
L_main3:
;USARTTX.c,51 :: 		crc_data[0]=55;
	MOVLW       55
	MOVWF       _crc_data+0 
;USARTTX.c,53 :: 		UART1_Write(crc_data[0]);
	MOVLW       55
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USARTTX.c,55 :: 		crc_data[1]='O';
	MOVLW       79
	MOVWF       _crc_data+1 
;USARTTX.c,57 :: 		UART1_Write(crc_data[1]);
	MOVLW       79
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USARTTX.c,58 :: 		crc_data[2]='K';
	MOVLW       75
	MOVWF       _crc_data+2 
;USARTTX.c,60 :: 		UART1_Write(crc_data[2]);
	MOVLW       75
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USARTTX.c,64 :: 		delay_ms(99);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       33
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
;USARTTX.c,70 :: 		}
	GOTO        L_main3
;USARTTX.c,71 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
