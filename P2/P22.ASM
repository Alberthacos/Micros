;PRACTICA 2 
;AL PRESIONAR PB0, SE ALMACENA DATO 1 Y SE IMPRIME EN C
;AL PRESIONAR PB0, SE ALMACENA DATO 2 Y SE IMPRIME EN C
;DESPUES SE ESPERA HASTA QUE SE PRESIONE PB0 Y DESPUES DE REALIZA LUCES
        
        
            INCLUDE         <ENCABEZADO.INC>        ;B1
            CLRF            TRISC
            BCF             STATUS,RP0              ;B0
;PRESIONAR PB0 PARA DATO 1 


                MOVLW           .8             ;GUARDA EL VALOR DE D EN W
                MOVWF           PORTC          ;GUARDA EL VALOR DE W EN PORTC

            ;---------
				BSF			0X23,2			;LIMPIA REG GENERAL PARA CONTEOS
                MOVLW           .2

DEC_DIV:		SUBWF			PORTC,F			;(REG0X21 - 2) -->> W	 // (DATO1 - DATO2)	 RESTA HASTA CUMPLIR UNA DE LAS 2 CONDICIONES
				BTFSC			STATUS,Z		;EL RESULTADO DE LA RESTA ES CERO?
				GOTO			RESUL_DIV		;	ES CERO (POR LO TANTO NO TIENE RESIDUO)
				INCF			0X23,F			;	NO 	//	INCREMENTA EN UNO LOS ENTEROS DE LA DIVISION
				GOTO			DEC_DIV			;  	NO ES NEGATIVO (VUELVE A RESTAR)

RESUL_DIV:		INCF			0X23,F
				MOVF			0X23,W
				MOVWF 			PORTC			;MUESTRA LA CANTIDAD DE ENTEROS POR EL PORTC


            ;--------

				

            GOTO            FIN


;---------------------TIEMPOS--------------

T25MS:  MOVLW           .3   ;VAR1
        MOVWF           0X64
        MOVLW           .47   ;VAR2
        MOVWF           0X65
        MOVLW           .25   ;VAR3
        MOVWF           0X66
        CALL            ST3V
        RETURN

T300MS: MOVLW           .4   ;VAR1
        MOVWF           0X64
        MOVLW           .124   ;VAR2
        MOVWF           0X65
        MOVLW           .86   ;VAR3
        MOVWF           0X66
        CALL            ST3V
        RETURN

FIN:    GOTO            $
        INCLUDE         <SUBTIEMPO.ASM>
        END






;            MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC
;
;;PRESIONAR PB0 PARA LUCES
;
;            BTFSS           PORTB,0
;            GOTO            $-1
;            CALL            T25MS
;            BTFSC           PORTB,0
;            GOTO            $-1
;            CALL            T25MS
;
;            MOVLW           0X07        ;CARGA 0X05 A W
;            MOVWF           0X30        ;GUARDA EL VALOR EN EL REG 0X30
;
;            MOVLW           0X00        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
;
;            MOVLW           0X01        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
;
;SUMA:       MOVF            PORTC,W     ;EL VALOR DE PORTC LO GUARDA EN W
;            ADDWF           PORTC,F     ;SUMA W CON PORTC 
;            CALL            T300MS      ;LLAMA A LA RUTINA T300MS
;            DECFSZ          0X30,F      ;DECREMENTA EN 1 AL REG 0X30 
;            GOTO            SUMA        ;EJECUTA SI /= 0
;
;            CLRF            0X30        ;EJECUTA SI = 0
;            MOVLW           0X40        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
;
;            MOVLW           0X20        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
;
;            MOVLW           0X10        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
; 
;            MOVLW           0X08        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
; 
;            MOVLW           0X04        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
; 
;            MOVLW           0X02        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
; 
;            MOVLW           0X01        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
;
;            MOVLW           0X00        ;A T300MS LE FALTAN 3 NOPS 
;            MOVWF           PORTC  
;            CALL            T300MS
; 