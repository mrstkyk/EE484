
_interrupt:

;USARTRX.c,22 :: 		void interrupt()
;USARTRX.c,25 :: 		if(PIR1.RCIF)
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt0
;USARTRX.c,28 :: 		PIR1.RCIF=0;   //LED 1
	BCF         PIR1+0, 5 
;USARTRX.c,29 :: 		PORTC.F0=1;
	BSF         PORTC+0, 0 
;USARTRX.c,30 :: 		UART1_Read_Text(output,"OK", 30);    // reads text until 'OK' is found
	MOVLW       _output+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr1_USARTRX+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr1_USARTRX+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       30
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;USARTRX.c,35 :: 		UART1_Write_Text(output); UART1_Write(79); UART1_Write(75);
	MOVLW       _output+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_output+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
	MOVLW       79
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	MOVLW       75
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;USARTRX.c,38 :: 		}
L_interrupt0:
;USARTRX.c,39 :: 		}
L_end_interrupt:
L__interrupt4:
	RETFIE      1
; end of _interrupt

_main:

;USARTRX.c,41 :: 		void main()
;USARTRX.c,44 :: 		TRISC.F0=0;
	BCF         TRISC+0, 0 
;USARTRX.c,45 :: 		PORTC.F0=0;
	BCF         PORTC+0, 0 
;USARTRX.c,46 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;USARTRX.c,48 :: 		TRISB = 0;
	CLRF        TRISB+0 
;USARTRX.c,49 :: 		PORTB = 0;
	CLRF        PORTB+0 
;USARTRX.c,52 :: 		UART1_Init(9600);    // UART 9600 Baudrate ile baslatýldý.
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;USARTRX.c,53 :: 		INTCON.GIE = 1;      // GLOBAL INTERRUPT ENABLE
	BSF         INTCON+0, 7 
;USARTRX.c,54 :: 		PIE1.RCIE = 1;       // RECIEVE INTERRUPT ENABLE
	BSF         PIE1+0, 5 
;USARTRX.c,55 :: 		INTCON.PEIE = 1;     // peripheral intterrupt
	BSF         INTCON+0, 6 
;USARTRX.c,56 :: 		PIR1.RCIF=0;         // RX FLAG BIT
	BCF         PIR1+0, 5 
;USARTRX.c,57 :: 		RCSTA.CREN=1;
	BSF         RCSTA+0, 4 
;USARTRX.c,61 :: 		while (1)
L_main1:
;USARTRX.c,67 :: 		}
	GOTO        L_main1
;USARTRX.c,68 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
