
				INCLUDE			<ENCABEZADO.INC>
				BCF 			TRISD,7			;PUERTO SALIDA PARA CONTROL DE MOTOR						
				BCF				TRISB,7			;SACA 0 en PORTB,7
				BCF				STATUS,RP0		;B0
				BSF				PORTD,7			;ENCIENDE EL MOTOR

POS0:			BTFSS			PORTD,0			;PORTD.0 = 1?
				GOTO			POS0			;SI  PORTD.0 = 0 
				BCF				PORTD,7			;SI  PORTD.0 = 1 

				MOVF			PORTD,W			;MUEVE LO DE PORTD A W 
				ANDLW			B'1000000'		;COMPARA			