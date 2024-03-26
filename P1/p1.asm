
				INCLUDE			<ENCABEZADO.INC>
				CLRF 			TRISC
				BCF				TRISB,7		;SACA 0 en PORTB,7
				BCF				STATUS,RP0	;B0
				CLRF			0X20		;DATO 1 ORIGINAL
				CLRF			0X21		;DATO 2 COPIA
				CLRF			0X22		;DATO 2 ORGINAL
				CLRF 			0X23		;DATO 1 COPIA

PUSHBUTTON:		BTFSS			PORTB,0			;PORTA.0 = 1?
				GOTO			PUSHBUTTON		;SI  PORTA.0 = 0 
				MOVF			PORTD,W			;SI  PORTA.0 = 1 // CARGA EL VALOR EN EL ACUMULADOR 
				MOVWF			PORTC			; W -->> PORTC
				MOVWF			0X20			; W -->> 0X20  DATO 1
				MOVWF			0X23			; W -->> 0X20  COPIA DATO 1

;--------------------------------------------------------------------------------------
SUMA:			BTFSS			PORTB,1			
				GOTO 			RESTA	
				MOVF 			PORTD,W			;PORTD -->> W
				MOVWF 			0X22			;			W -->> 0X22 ( DATO 2)
				MOVF            0X20,W			;0X20 -->> W 
				ADDWF			PORTD,W			;W + PORTD -->> W
				MOVWF			PORTC			;W -->> PORTC
				GOTO			DIVISION
;-----------------------------------------------------------------------------------------

RESTA:			BTFSS			PORTB,2	
				GOTO 			MULTIPLICACION
				MOVF			PORTD,W			;PORTD -->> W	
				MOVWF 			0X22			;			W -->> 0X22 ( DATO 2)
				SUBWF			0X20,W			;(0X20 - W) -->> W
				BTFSS 			STATUS,C		;ES NEGATIVO?
				GOTO			NEGATIVO
CONTINUAR:		MOVWF			PORTC
				GOTO			DIVISION				

NEGATIVO:		SUBLW			0X00
				BSF 			PORTB,7
				GOTO 			CONTINUAR

;-----------------------------------------------------------------------------------		

MULTIPLICACION:	BTFSS 			PORTB,3 	
				GOTO 			SUMA			;VA A REVISAR SI SE PREISONA PB0
				MOVF 			PORTD,W			;PORTD -->> W
				MOVWF			0X22			;		    W -->> 0X22  ( DATO 2)
				MOVWF			0X21			;			W -->> 0X21

DEC_MULTI:		DECFSZ			0X23,F			;(0X23 - 1) = 0X23   //  SKIP IF = 0		
				GOTO 			SUMA_MULTI
				BTFSC			STATUS,C		;SOBREPASA EL ACARREO?
				BSF				PORTB,7
				MOVF			0X21,W			;CARGA EL RESULTADO DE LA SUMA EN W
				MOVWF			PORTC
				GOTO			DIVISION

SUMA_MULTI:		ADDWF			0X21,F			;( W + 0X21(W) ) -->> 0X21  
				GOTO			DEC_MULTI

;---------------------------------------------------------------------------------
DIVISION:		BTFSS			PORTB,0			;ESPERA QUE SE PRESIONE EL BOTON 
				GOTO			DIVISION
				CLRF			0X24			;LIMPIA REG QUE ALMACENA LE COCIENTE
				BCF				STATUS,C		;LIMPIA C, CARRY

				MOVF 			0X20,W			;0X22 -->>  W			DATO1
				MOVWF 			0X23			;			W -->> 0x23 COPIA 

				MOVF 			0X22,W			;0X20 -->> 	W			DATO2
				BTFSC			STATUS,Z		;COMPRUEBA SI EL DATO 2 = 0
				GOTO			DIV_Z			;	DATO 2 = 0
				MOVWF 			0X21			;	DATO 2 != 0	W -->> 0X21	COPIA

DEC_DIV:		SUBWF			0X23,F			;(REG0X20 - W) -->> F	 // (DATO1 - DATO2)	 RESTA HASTA CUMPLIR UNA DE LAS 2 CONDICIONES
				BTFSC			STATUS,Z		;EL RESULTADO DE LA RESTA ES CERO?
				GOTO			RESUL_DIV		;	ES CERO (POR LO TANTO NO TIENE RESIDUO)
				BTFSS			STATUS,C		;EL RESULTADO ES NEGATIVO?	
				GOTO			RESIDUO			;	ES NEGATIVO		(TIENE RESIDUO) 
				INCF			0X24,F			;	NO ES NEGATVO	//	INCREMENTA EN UNO LOS ENTEROS DE LA DIVISION
				GOTO			DEC_DIV			;  	(VUELVE A RESTAR)

RESIDUO:		BSF				PORTB,7			;ENCIENDE PB7 INDICANDO QUE HAY RESIDUO
				GOTO 			FIN

RESUL_DIV:		INCF			0X24,F			;INCREMENTA EN UNO EL DIVIDENDO
				MOVF			0X24,W			
				MOVWF 			PORTC			;MUESTRA LA CANTIDAD DE ENTEROS (dividendo) POR EL PORTC
				GOTO			FIN

DIV_Z:			MOVLW			0XFF			;EL DATO 2 = 0, LA SALIDA DEBE SER 0XFF
				MOVWF			PORTC			
				BSF				PORTB,7			;SE ENCIENDE EL PORTB,7 


FIN:			GOTO			$
				END
				

				;0 = W
				;1 = REG

				;MOVWF W -->> F
				;MOVF F -->> 1,0




