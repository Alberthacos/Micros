;PRACTICA 2 
;AL PRESIONAR PB0, SE ALMACENA DATO 1 Y SE IMPRIME EN C
;AL PRESIONAR PB0, SE ALMACENA DATO 2 Y SE IMPRIME EN C
;DESPUES SE ESPERA HASTA QUE SE PRESIONE PB0 Y DESPUES DE REALIZA LUCES
        
        
                        INCLUDE         <ENCABEZADO.INC>        ;B1
                        INCLUDE         <VAR_LEDS.ASM>
                        CLRF            TRISC                   ;SALIDA OPERACIONES Y LUCES
                        CLRF            TRISA                   ;SALIDA MOTORES

                        BCF             TRISB,7					;LED ACARREO
                        BCF             TRISB,6					;MOTOR DC
                        BCF             TRISB,5					;PWM SERVO

     

                        BCF             STATUS,RP0              ;B0

DATO_1                  EQU             0X21            
DATO_2                  EQU             0X22 
						MOVLW			.10
						MOVWF			0X45
						
						

						;GOTO			MOV_MOTOR1
						
        
DATO1:                  PUSH_ANTIR      PORTB,0
                        ;BTFSS           PORTB,0
                        ;GOTO            $-1
                        ;CALL            T25MS
                        ;BTFSC           PORTB,0
                        ;GOTO            $-1
                        ;CALL            T25MS

                        MOVF            PORTD,W             ;GUARDA EL VALOR DE D EN W
                        MOVWF           DATO_1              ;GUARDA EL VALOR DE W EN 0X21 (DATO_1)
                        MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC 

DATO2:                  PUSH_ANTIR       PORTB,0
                        ;BTFSS           PORTB,0
                        ;GOTO            $-1
                        ;CALL            T25MS
                        ;BTFSC           PORTB,0
                        ;GOTO            $-1
                        ;CALL            T25MS

                        MOVF            PORTD,W             ;GUARDA EL VALOR DE D EN W
                        MOVWF           DATO_2              ;GUARDA EL VALOR DE W EN 0X22 (DATO_2)
                        MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC
                       	
                        
;-------------------------- MOVIVIENTO MOTOR -------------------------------      
CASO1:                  MOVF            DATO_1,W              ;0<= dato1 <= 60
                        SUBLW           .60
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 60)
						GOTO			CASO2
                        GOTO			ARRANQUE1

ARRANQUE1:            	BSF             PORTB,6
                       	SUBT2V          .45,.47
                       	SUBT2V          .45,.47

EN_RANGO1:              BTFSC           PORTB,4             ;ENVIA 0 CUANDO DETECTA IMAN SH1
                        GOTO            MOV_MOTOR1
                        BCF             PORTB,6
                        GOTO            CASOS1

MOV_MOTOR1:				BSF             PORTB,6
                        SUBT2V          .27,.1		;200 27,1 // 150 1,13 
                        BCF             PORTB,6
                        SUBT2V          .41,.1		;300 41,1 // 350 24,2

                        GOTO            EN_RANGO1

;----------------------hhhh-------------------------------------------
CASO2:                  MOVF            DATO_1,W              ;61<= dato1 <= 120
                        SUBLW           .120
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 120)
						GOTO			CASO3
                        GOTO			ARRANQUE2

ARRANQUE2:            	BSF             PORTB,6
                       	SUBT2V          .45,.47
                       	SUBT2V          .45,.47

EN_RANGO2:              BTFSC           PORTB,3             ;ENVIA 0 CUANDO DETECTA IMAN SH2
                        GOTO            MOV_MOTOR2
                        BCF             PORTB,6
                        GOTO            CASOS1

MOV_MOTOR2:				BSF             PORTB,6
                        SUBT2V          .1,.13		;200 27,1 // 150 1,13 
                        BCF             PORTB,6
                        SUBT2V          .24,.2		;300 41,1 // 350 24,2

                        GOTO            EN_RANGO2
;
;
CASO3:                  MOVF            DATO_1,W              ;121<= dato1 <= 180
                        SUBLW           .180
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 180)
						GOTO			CASO4
                        GOTO			ARRANQUE3

ARRANQUE3:            	BSF             PORTB,6
                       	SUBT2V          .45,.47
                       	SUBT2V          .45,.47

EN_RANGO3:              BTFSC           PORTB,2             ;ENVIA 0 CUANDO DETECTA IMAN SH3
                        GOTO            MOV_MOTOR3
                        BCF             PORTB,6
                        GOTO            CASOS1

MOV_MOTOR3:				BSF             PORTB,6
                        SUBT2V          .1,.13		;200 27,1 // 150 1,13 
                        BCF             PORTB,6
                        SUBT2V          .24,.2		;300 41,1 // 350 24,2

                        GOTO            EN_RANGO3
;
;
CASO4:                  MOVF            DATO_1,W              ;181<= dato1 <= 255
                        SUBLW           .255
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 255)
						GOTO			CASOS1
                        GOTO			ARRANQUE4

ARRANQUE4:            	BSF             PORTB,6
                       	SUBT2V          .45,.47
                       	SUBT2V          .45,.47

EN_RANGO4:              BTFSC           PORTB,1             ;ENVIA 0 CUANDO DETECTA IMAN SH4
                        GOTO            MOV_MOTOR4
                        BCF             PORTB,6
                        GOTO            CASOS1

MOV_MOTOR4:				BSF             PORTB,6
                        SUBT2V          .1,.13		;200 27,1 // 150 1,13 
                        BCF             PORTB,6
                        SUBT2V          .24,.2		;300 41,1 // 350 24,2

                        GOTO            EN_RANGO4    

;------------------------------MOVIMIENTO SERVO---------------------------------------

CASOS1:                MOVF            DATO_2,W              ;0<= dato <= 25
                       SUBLW           .25
                       BTFSS           STATUS,C           ;ES NEGATIVO? (MAYOR A 25)
                       GOTO            CASOS2                   ;SI    
                       GOTO            SERVO0

SERVO0:	            	BCF				PORTB,5	
						GOTO			SERVO0	

CASOS2:                MOVF            DATO_2,W              ;26 <= dato <= 50
                       SUBLW           .50
                       BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 50)
                       GOTO            CASOS3                   ;SI    
                       GOTO            SERVO20

SERVO20:	        	BSF				PORTB,5		;20_000uS  frecuencia de 50hz
						SUBT3V			.7,.15,.1	;1500	1.5ms	90 deg
						BCF				PORTB,5
						SUBT3V			.2,.59,.23	;18500	18.5ms
						DECFSZ			0X45,F
						GOTO			SERVO20	
						GOTO			PB_SUMA

CASOS3:                	MOVF            DATO_2,W              ;51<= dato <= 75
                       	SUBLW           .75
                       	BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 75)
                       	GOTO            CASOS4                   ;SI    
                       	GOTO            SERVO40


SERVO40:	        	BSF				PORTB,5		;200uS
						SUBT2V			.2,.56
						BCF				PORTB,5
						SUBT2V			.202,.13	
						DECFSZ			0X45,F
						GOTO			SERVO40	
						GOTO			PB_SUMA	          
;
CASOS4:                	MOVF            DATO_2,W              ;76<= dato <= 100
                       	SUBLW           .100
                       	BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 100)
                       	GOTO            CASOS5                   ;SI    
                       	GOTO            SERVO60

SERVO60:	        	BSF				PORTB,5		;300
						SUBT2V			.177,.1
						BCF				PORTB,5
						SUBT3V			.2,.95,.14	
						DECFSZ			0X45,F
						GOTO			SERVO60	
						GOTO			PB_SUMA                                                              

CASOS5:                	MOVF            DATO_2,W              ;101<= dato <= 125
                       	SUBLW           .125
                       	BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 125)
                       	GOTO            CASOS6                   ;SI    ;;;;;;--------------------------------------------------********************
                       	GOTO            SERVO80

SERVO80:	        	BSF				PORTB,5		;400
						SUBT2V			.5,.37
						BCF				PORTB,5
						SUBT3V			.1,.71,.37	
						DECFSZ			0X45,F
						GOTO			SERVO80	
						GOTO			PB_SUMA

CASOS6:                	MOVF            DATO_2,W              ;126<= dato <= 150
                        SUBLW           .150
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 150)
                        GOTO            CASOS7                   ;SI    ;;;;;;--------------------------------------------------********************
                        GOTO            SERVO100

SERVO100:	        	BSF				PORTB,5		;400
						SUBT3V			.1,.27,.2
						BCF				PORTB,5
						SUBT3V			.1,.27,.2	
						DECFSZ			0X45,F
						GOTO			SERV
						
						O100	
						GOTO			PB_SUMA	
;
CASOS7:                 MOVF            DATO_2,W              ;151<= dato <= 175
                        SUBLW           .175
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 60)
                        GOTO            CASOS7                   ;SI    ;;;;;;--------------------------------------------------********************
                        GOTO            SERVO120
 
SERVO120:	        	BSF				PORTB,5		;400
						SUBT3V			.1,.1,.167
						BCF				PORTB,5
						SUBT2V			.94,.27	
						DECFSZ			0X45,F
						GOTO			SERVO120	
						GOTO			PB_SUMA   
;
CASOS8:                 MOVF            DATO_2,W              ;176<= dato <= 200
                        SUBLW           .200
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 200)
                        GOTO            CASOS8                   ;SI    ;;;;;;--------------------------------------------------********************
                        GOTO            SERVO140

SERVO140:	        	BSF				PORTB,5		;400
						SUBT2V			.21,.14
						BCF				PORTB,5
						SUBT2V			.18,.141	
						DECFSZ			0X45,F
						GOTO			SERVO140	
						GOTO			PB_SUMA    

CASOS9:                 MOVF            DATO_2,W              ;201<= dato <= 225
                        SUBLW           .225
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 225)
                        GOTO            CASOS10                   ;SI    ;;;;;;--------------------------------------------------********************
                        GOTO            SERVO160

SERVO160:	        	BSF				PORTB,5		;400
						SUBT2V			.4,.73
						BCF				PORTB,5
						SUBT2V			.70,.36	
						DECFSZ			0X45,F
						GOTO			SERVO160	
						GOTO			PB_SUMA   

CASOS10:               MOVF            DATO_2,W              ;225<= dato <= 255
                       SUBLW           .255
                       BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 255)
                       GOTO            PB_SUMA                   ;SI    ;;;;;;--------------------------------------------------********************
                       GOTO            SERVO180

SERVO180:	        	BSF				PORTB,5		;400
						SUBT3V			.1,.27,.2
						BCF				PORTB,5
						SUBT3V			.1,.27,.2	
						DECFSZ			0X45,F
						GOTO			SERVO180	
						GOTO			PB_SUMA                                                                                       
;------------------------------- OPERACIONES--------------------------------------

PB_SUMA:                PUSH_ANTIR      PORTB,0         ;PRESIONAR PB0 PARA LUCES Y SUMA

                        BCF             PORTB,7
                        CLRF            PORTC
                        CALL            LUCES
                        CLRF            PORTC

                        BCF             STATUS,C
                        MOVF            DATO_1,W        ;CARGA DATO1 EN W
                        ADDWF           DATO_2,W        ;SUMA DATO1(W)+DATO2    -->> W
                        MOVWF           0X24	        ;RESULTADO SUMA         -->> 0X24

                        BTFSS           STATUS,C
                        GOTO            RESULTADO            
                        CALL            PARPADEO
                        BSF             PORTB,7
            
RESULTADO:              MOVF            0X24,W          ;RESULTADO SUMA 
                        MOVWF           PORTC           ;SACA EL RESULTADO POR PORTC

PB_RESTA:               PUSH_ANTIR      PORTB,0         ;PRESIONAR PB0 PARA RESTA LUCES
                        BCF             PORTB,7
                        CLRF            PORTC
                        CALL            LUCES
                        CLRF            PORTC

                        MOVF            DATO_2,W        ;CARGA DATO 2 EN EL ACUMULADOR
                        SUBWF           DATO_1,W        ;RESTA DATO_1 - DATO_2 => W
                        MOVWF           0X25
						BTFSS 			STATUS,C	;ES NEGATIVO?
						GOTO			NEGATIVO
CONTINUAR:	        	MOVWF			PORTC
						GOTO			PB_MULTIPLICACION

NEGATIVO:	        	CALL            PARPADEO
                        MOVF            0X25,W
                        SUBLW			0X00
                        BSF             PORTB,7
						GOTO 			CONTINUAR
           

PB_MULTIPLICACION:      PUSH_ANTIR      PORTB,0         ;PRESIONAR PB0 PARA MULTIPLICACION
                        BCF             PORTB,7
                        CLRF            PORTC
                        CALL            LUCES
                        CLRF            PORTC

						MOVF 			DATO_1,W			
						MOVWF			0X23			;W -->> 0X23  (COPIA DATO 1)
						MOVF 			DATO_2,W			
						MOVWF			0X24			;W -->> 0X24  (COPIA DATO 2)

DEC_MULTI:				DECFSZ			0X23,F			;(0X23 - 1) = 0X23   //  SKIP IF = 0		
						GOTO 			SUMA_MULTI
						BTFSC			STATUS,C		;SOBREPASA EL ACARREO?
						GOTO            EXCEDE_MULTI
CARGA_RES:				MOVF			0X24,W			;CARGA EL RESULTADO DE LA SUMA EN W
						MOVWF			PORTC
						GOTO			PB_DIVISION

SUMA_MULTI:				ADDWF			0X24,F			;( W + 0X21(W) ) -->> 0X24  
						GOTO			DEC_MULTI

EXCEDE_MULTI:           BSF				PORTB,7
                        CALL            PARPADEO
                        GOTO            CARGA_RES                        

PB_DIVISION:            PUSH_ANTIR      PORTB,0  
                        BCF             PORTB,7
                        CLRF            PORTC
                        CALL            LUCES
						CLRF			0X24			;LIMPIA REG QUE ALMACENA EL COCIENTE
						BCF				STATUS,C			;LIMPIA C, CARRY

						MOVF 			DATO_1,W		;0X22 -->>  W			DATO1
						MOVWF 			0X23			;			W -->> 0x23 COPIA 

						MOVF 			DATO_2,W		;0X20 -->> 	W			DATO2
						BTFSC			STATUS,Z		;COMPRUEBA SI EL DATO 2 = 0
						GOTO			DIV_Z			;	DATO 2 = 0
						;MOVWF 			0X21			;	DATO 2 != 0	W -->> 0X21	COPIA

DEC_DIV:				SUBWF			0X23,F			;(REG0X20 - W) -->> F	 // (DATO1 - DATO2)	 RESTA HASTA CUMPLIR UNA DE LAS 2 CONDICIONES
						BTFSC			STATUS,Z		;EL RESULTADO DE LA RESTA ES CERO?
						GOTO			RESUL_DIV		;	ES CERO (POR LO TANTO NO TIENE RESIDUO)
						BTFSS			STATUS,C		;EL RESULTADO ES NEGATIVO?	
						GOTO			RESIDUO			;	ES NEGATIVO		(TIENE RESIDUO) 
						INCF			0X24,F			;	NO ES NEGATVO	//	INCREMENTA EN UNO LOS ENTEROS DE LA DIVISION
						GOTO			DEC_DIV			;  	(VUELVE A RESTAR)

RESIDUO:				BSF				PORTB,7			;ENCIENDE PB7 INDICANDO QUE HAY RESIDUO
                        CALL        	PARPADEO
						MOVF			0X24,W			
						MOVWF 			PORTC			;MUESTRA LA CANTIDAD DE ENTEROS (dividendo) POR EL PORTC
						GOTO			PB_VAR1

RESUL_DIV:				INCF			0X24,F			;INCREMENTA EN UNO EL DIVIDENDO
						MOVF			0X24,W			
						MOVWF 			PORTC			;MUESTRA LA CANTIDAD DE ENTEROS (dividendo) POR EL PORTC
						GOTO			PB_VAR1

DIV_Z:					MOVLW			0XFF			;EL DATO 2 = 0, LA SALIDA DEBE SER 0XFF
						MOVWF			PORTC			
						BSF				PORTB,7			;SE ENCIENDE EL PORTB,7 


PB_VAR1:                PUSH_ANTIR      PORTB,0
                        MOVF            PORTD,W
                        MOVWF           0X27
                        MOVWF           PORTC

PB_VAR2:                PUSH_ANTIR      PORTB,0
                        MOVF            PORTD,W
                        MOVWF           0X28
                        MOVWF           PORTC

PB_VAR3:                PUSH_ANTIR      PORTB,0
                        MOVF            PORTD,W
                        MOVWF           0X29
                        MOVWF           PORTC

PB_STV:                 PUSH_ANTIR      PORTB,0
ENCENDER_LEDS:          MOVLW           0XFF
                        MOVWF           PORTC
                        ;SUBT3V          .69,.29,.105
                        MOVF			0X27,W	;VARIABLE1 DE SUBRUTINA DE TIEMPO.
						MOVWF			0x66
						MOVF			0X28,W	;VARIABLE2 DE SUBRUTINA DE TIEMPO.
						MOVWF			0x65
						MOVF			0X29,W	;VARIABLE3 DE SUBRUTINA DE TIEMPO.
						MOVWF			0x64
						CALL			ST3V
                        
                        CLRF            PORTC
                        ;SUBT3V          .69,.29,.105

                        MOVF			0X27,W	;VARIABLE1 DE SUBRUTINA DE TIEMPO.
						MOVWF			0x66
						MOVF			0X28,W	;VARIABLE2 DE SUBRUTINA DE TIEMPO.
						MOVWF			0x65
						MOVF			0X29,W	;VARIABLE3 DE SUBRUTINA DE TIEMPO.
						MOVWF			0x64
						CALL			ST3V

                        GOTO            ENCENDER_LEDS


;-------------------PARPADEO-------------
PARPADEO:               MOVLW           .8
                        MOVWF           0X23
                        MOVLW           0XFF
                        MOVWF           PORTC
                        CALL            T500MS
                        COMF            PORTC,F
                        CALL            T500MS
                        DECFSZ          0X23,F         
                        GOTO            $-3
						BSF				PORTB,7
                        RETURN


;-----------------LUCES----------------------
;INICIO DEL PROGRAMA PARA INCISOS A) HASTA I)	

LUCES:			OA
			CALL		T300MS
			IA
			CALL		T300MS
			OA
			IB
			CALL		T300MS
			OB
			IC
			CALL		T300MS
			OC
			ID
			CALL		T300MS
			OD
			IE
			CALL		T300MS
			OE
			LF
			CALL		T300MS
			OF
			IG
			CALL		T300MS
			OG
			IH
			CALL		T300MS ;Aqu� empieza a regresar la secuencia
			OH
			IG
			CALL		T300MS
			OG
			LF
			CALL		T300MS
			OF
			IE
			CALL		T300MS
			OE
			ID
			CALL		T300MS
			OD
			IC
			CALL		T300MS
			OC
			IB
			CALL		T300MS
			IA
			OB
			CALL		T300MS
			OA
			CALL		T300MS
;Fin de la rutina de a) hasta i)		
			QR
			CALL		T300MS
			QS
			CALL		T300MS
			QT
			CALL		T300MS
			QU
			CALL		T300MS
			QV
			CALL		T300MS
			QW
			CALL		T300MS
			QX
			CALL		T300MS
			QY
			CALL		T300MS
			QZ
			CALL		T300MS
			AA
			CALL		T300MS
			AB
			CALL		T300MS
			AC
			CALL		T300MS
			AD
			CALL		T300MS
			AE
			CALL		T300MS
			AF
			CALL		T300MS
			AG	
                        RETURN

;---------------------TIEMPOS--------------
T25MS:                  MOVLW           .3   ;VAR1
                        MOVWF           0X64
                        MOVLW           .47   ;VAR2
                        MOVWF           0X65
                        MOVLW           .25   ;VAR3
                        MOVWF           0X66
                        RETURN
                        CALL            ST3V

T300MS:                 MOVLW           .4   ;VAR1
                        MOVWF           0X64
                        MOVLW           .124   ;VAR2
                        MOVWF           0X65
                        MOVLW           .86   ;VAR3
                        MOVWF           0X66
                        CALL            ST3V
                        RETURN

T500MS:                 MOVLW           .79   ;VAR1
                        MOVWF           0X64
                        MOVLW           .3   ;VAR2
                        MOVWF           0X65
                        MOVLW           .253   ;VAR3
                        MOVWF           0X66
                        CALL            ST3V
                        RETURN
T150US:                 MOVLW           .13   ;VAR2
                        MOVWF           0X61
                        MOVLW           .1   ;VAR1
                        MOVWF           0X62
                        CALL            ST2V
                        RETURN

FIN:    GOTO            $
        INCLUDE         <SUBTIEMPO.ASM>
        END






            

 