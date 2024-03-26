;SACA POR EL PUERTO B EL VALOR 0X55
;SACA POR EL PUERTO C EL VALOR 0XAA
;SACA POR EL PUERTO D EL VALOR 0XCC

			PROCESSOR 	16F887
			__CONFIG 	0X2007,23E4
			__CONFIG 	0X2008,3FF
			INCLUDE 	<P16F887.INC>
			ORG 		0X0000
			
;PARA CAMBIAR DE BANCO SE MODIFICAN LOS BITS 
;RP1 Y RP0 DEL REG. STATUS
;0		0	BANCO 0
;0		1	BANCO 1
;1		0	BANCO 2
;1		1	BANCO 3
			MOVLW 		0X55
			MOVWF 		PORTB
			MOVLW 		0XAA
			MOVWF 		PORTC
			MOVLW 		0XCC
			MOVWF 		PORTD

			BSF 		STATUS, RP0
			BSF 		STATUS, RP1 	;B3
			CLRF 		ANSEL 
			CLRF 		ANSELH			;TODOS LOS PUERTOS SON DIGITALES  
			BCF 		STATUS, RP1		;B1
			CLRF 		TRISB			;SE CONFIGURAN COMO SALIDAS
			CLRF 		TRISC
			CLRF 		TRISD
SINFIN: 	GOTO		SINFIN 
			END
