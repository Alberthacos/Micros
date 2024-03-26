
			INCLUDE <ENCABEZADO.INC>

;DEFINIMOS LAS SALIDAS DEL MICROCONTROLADOR
			CLRF		TRISC			;PORTC SALIDA 
			BCF			TRISB,1         
			BCF			STATUS,RP0		;B0
			
		

;*********************************************************************************************
;DECLARACION DE REGISTROS A EMPLEAR
			VAR_ACTUAL 	EQU		0X20	;VALOR DE INTENSIDAD ACTUAL	

			VAR_DIP		EQU		0X21	;VALOR EN 
										
			
;REGISTROS DE APOYO PARA SABER LA DIFERENCIA ENTRE LA POSCION ACTUAL Y LA POSTERIOR
			

;******************************************************************************************
;INCREMENTO: PUSH_ANTIR  PORTB,0         ;SI SE PRESIONA PB0 SE INCREMENTA EL VALOR ACTUAL 
            ;INCF        VAR_ACTUAL

            CLRF            VAR_ACTUAL  ;SE INCICIA EN 00 VALOR ACTUAL

            GOTO            NIVEL8

INCREMENTO: BTFSS           PORTB,0     ;SI SE PRESIONA PB0 INCREMENTA EL VALOR ACTUAL 
            GOTO            DECREMENTO
            CALL            T25MS
            BTFSC           PORTB,0
            GOTO            $-1
            CALL            T25MS
            INCF            VAR_ACTUAL,F

            MOVF            VAR_ACTUAL,W;SACA LO QUE TIENE VAR_ACTUAL
            MOVWF           PORTC       ;CARGALO EN PORTC

            GOTO            DECREMENTO

DECREMENTO: BTFSS           PORTB,1     ;SI SE PRESIONA PB1 DECREMENTA EL VALOR ACTUAL 
            GOTO            LEER_DIP
            CALL            T25MS
            BTFSC           PORTB,1
            GOTO            $-1
            CALL            T25MS
            DECF            VAR_ACTUAL,F;DECREMENTA EN UNO AL VALOR ACTUAL 
            
            MOVF            VAR_ACTUAL,W;SACA LO QUE TIENE VAR_ACTUAL
            MOVWF           PORTC       ;CARGALO EN PORTC

            GOTO            LEER_DIP

LEER_DIP:   BTFSS           PORTB,2     ;SI SE PRESIONA PB2 SE LEE PORTD Y SE ACTUALIZA EL VALOR ACTUAL 
            GOTO            INCREMENTO
            CALL            T25MS
            BTFSC           PORTB,2
            GOTO            $-1
            CALL            T25MS
            MOVF            PORTD,W     ;LEE PORTD Y SE CARGA EN W   
            MOVWF           VAR_ACTUAL  ;SE ACTUALIZA VAR_ACTUAL

            MOVWF           PORTC       ;SE ACTUALIZA PORTC

            GOTO            INCREMENTO




SEL_NIVEL:  MOVF            VAR_ACTUAL,W    ;EXTRAE VALOR ACTUAL    SELECCIONA EL NIVEL DE INTENSIDAD LUMINICA    
            SUBLW           .1              ;K-W -->> W     1 - VAR_ACTUAL-->>W
            BTFSS           STATUS,Z        ;EL RESULTADO ES CERO
            GOTO            NIVEL1          ;
            
            MOVF            VAR_ACTUAL,W    ;EXTRAE VALOR ACTUAL     
            SUBLW           .2              ;K-W -->> W     2 - VAR_ACTUAL-->>W
            BTFSS           STATUS,Z        ;EL RESULTADO ES CERO
            GOTO            NIVEL2          ;
            
            MOVF            VAR_ACTUAL,W    ;EXTRAE VALOR ACTUAL     
            SUBLW           .3              ;K-W -->> W     2 - VAR_ACTUAL-->>W
            BTFSS           STATUS,Z        ;EL RESULTADO ES CERO
            GOTO            NIVEL3          ;
            


;----------------------NIVELES PWM-------------------------

NIVEL1:	    BSF				PORTB,3		;
		     SUBT3V			.3,.1,.1
		    BCF				PORTB,3
		     SUBT2V			.1,.70
		    GOTO			NIVEL1	

NIVEL2:	    BSF				PORTB,3		;
		     SUBT3V			.1,.0,.24   ;CHECAR
		    BCF				PORTB,3
		     SUBT2V			.1,.65	
		    GOTO			NIVEL2	

NIVEL3:	    BSF				PORTB,3		;
		     SUBT2V			.7,.3
		    BCF				PORTB,3
		     SUBT2V			.0,.164     ;CHECAR
		    GOTO			NIVEL3	

NIVEL4:	    BSF				PORTB,3		;
		     SUBT3V			.1,.1,.19
		    BCF				PORTB,3
		     SUBT2V			.0,.151	    ;CHECAR
		    GOTO			NIVEL4	               

NIVEL5:	    BSF				PORTB,3		;
		     SUBT2V			.2,.15
		    BCF				PORTB,3
		     SUBT2V			.0,.137	    ;CHECAR
		    GOTO			NIVEL5

NIVEL6:	    BSF				PORTB,3		;
		     SUBT2V			.46,.1
		    BCF				PORTB,3
		     SUBT3V			.1,.69,.1	    ;
		    GOTO			NIVEL6	               

NIVEL7:	    BSF				PORTB,3		;
		     SUBT3V			.1,.3,.15
		    BCF				PORTB,3
		     SUBT3V			.1,.61,.1	    ;
		    GOTO			NIVEL7	               

NIVEL8:	    BSF				PORTB,3		;
		     SUBT3V			.1,.61,.1
		    BCF				PORTB,3
		     SUBT3V			.1,.3,.15	    ;
		    GOTO			NIVEL8	               

NIVEL9:	    BSF				PORTB,3		;
		     SUBT3V			.1,.69,.1
		    BCF				PORTB,3
		     SUBT2V			.46,.1	    ;
		    GOTO			NIVEL9	               
NIVEL10:	BSF				PORTB,3		;
		     SUBT2V			.0,.137     ;CHECAR
		    BCF				PORTB,3
		     SUBT2V			.2,.15	    ;
		    GOTO			NIVEL10	          

NIVEL11:	BSF				PORTB,3		;
		     SUBT2V			.0,.151     ;CHECAR
		    BCF				PORTB,3
		     SUBT3V			.1,.1,.19	    ;
		    GOTO			NIVEL11	           

NIVEL12:	BSF				PORTB,3		;
		     SUBT3V			.1,.0,.163  ;CHECAR
		    BCF				PORTB,3
		     SUBT2V			.7,.3	    ;
		    GOTO			NIVEL12	               

NIVEL13:	BSF				PORTB,3		;
		     SUBT2V			.1,.65
		    BCF				PORTB,3
		     SUBT2V			.0,.26	    ;CHECAR
		    GOTO			NIVEL13	               

NIVEL14:	BSF				PORTB,3		;
		     SUBT2V			.1,.70
		    BCF				PORTB,3
		     SUBT3V			.3,.1,.1	    ;
		    GOTO			NIVEL14	               

NIVEL15:	BSF				PORTB,3		;
		    GOTO			NIVEL15	               



;---------------------TIEMPOS--------------
T25MS:                  MOVLW           .3   ;VAR1
                        MOVWF           0X64
                        MOVLW           .47   ;VAR2
                        MOVWF           0X65
                        MOVLW           .25   ;VAR3
                        MOVWF           0X66
                        RETURN
                        CALL            ST3V

FIN:        GOTO        $



            INCLUDE         <SUBTIEMPO.ASM>
            END             