			INCLUDE		<MACROS_2.2.ASM>
			PROCESSOR 	16F887			
			__CONFIG 	0X2007,23E4		
			__CONFIG	0X2008,3FFF
			INCLUDE		<P16F887.INC>	
			ORG			0X0000
			CLRF		PORTA			
			CLRF		PORTB	
			CLRF		PORTC
			CLRF		PORTD
			CLRF		PORTE
			BSF			STATUS,RP0		;B1
			BSF			STATUS,RP1		;B3
			CLRF 		ANSEL			
			CLRF 		ANSELH		
			BCF			STATUS,RP1		;B1