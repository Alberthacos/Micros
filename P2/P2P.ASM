;PRACTICA 2 
;AL PRESIONAR PB0, SE ALMACENA DATO 1 Y SE IMPRIME EN C
;AL PRESIONAR PB0, SE ALMACENA DATO 2 Y SE IMPRIME EN C
;DESPUES SE ESPERA HASTA QUE SE PRESIONE PB0 Y DESPUES DE REALIZA LUCES
        
        
                        INCLUDE         <ENCABEZADO.INC>        ;B1
                        CLRF            TRISC                   ;SALIDAS DATOS 
                        CLRF            TRISA                   ;SALIDAS MOTORES   
                          

                        

                        BCF             STATUS,RP0              ;BANCO 0


DATO_1                  EQU             0X21            
DATO_2                  EQU             0X22            


DATO1:                  PUSH_ANTIR      PORTB,0             ;PRESIONAR PB0 PARA DATO 1

                        MOVF            PORTD,W             ;GUARDA EL VALOR DE D EN W
                        MOVWF           DATO_1              ;GUARDA EL VALOR DE W EN 0X21 (DATO_1)
                        MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC 


;DATO2:                  PUSH_ANTIR      PORTB,0             ;PRESIONAR PB0 PARA DATO 2
;
;                        MOVF            PORTD,W             ;GUARDA EL VALOR DE D EN W
;                        MOVWF           DATO_2              ;GUARDA EL VALOR DE W EN 0X22 (DATO_2)
;                        MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC


CASO1:                  MOVF            DATO_1,W              ;0<= dato <= 60
                        SUBLW           .60
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 60)
                        GOTO            CASO2               ;SI    
                        GOTO            EN_RANGO1

EN_RANGO1:              BTFSS           PORTB,1             ;ENVIA 1 CUANDO DETECTA IMAN 
                        GOTO            MOV_MOTOR1
                        BCF             PORTA,7
                        GOTO            FIN

MOV_MOTOR1:              BSF             PORTA,7
                        GOTO            EN_RANGO1


CASO2:                  MOVF            DATO_1,W            ;61 <= DATO1 <= 120
                        SUBLW           .120
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 120)
                        GOTO            CASO3               ;SI    
                        GOTO            EN_RANGO2

EN_RANGO2:              BTFSS           PORTB,2             ;ENVIA 1 CUANDO DETECTA IMAN 
                        GOTO            MOV_MOTOR2
                        BCF             PORTA,7
                        GOTO            FIN

MOV_MOTOR2:             BSF             PORTA,7
                        GOTO            EN_RANGO2


CASO3:                  MOVF            DATO_1,W            ;121 <= DATO1 <= 180
                        SUBLW           .180
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 180)
                        GOTO            CASO4                 ;SI    
                        GOTO            EN_RANGO3

EN_RANGO3:              BTFSS           PORTB,3             ;ENVIA 1 CUANDO DETECTA IMAN 
                        GOTO            MOV_MOTOR3
                        BCF             PORTA,7
                        GOTO            FIN

MOV_MOTOR3:             BSF             PORTA,7
                        GOTO            EN_RANGO3


CASO4:                  MOVF            DATO_1,W            ;181 <= DATO1 <= 255
                        SUBLW           .255
                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 255)
                        GOTO            FIN                 ;SI    
                        GOTO            EN_RANGO4

EN_RANGO4:              BTFSS           PORTB,4             ;ENVIA 1 CUANDO DETECTA IMAN 
                        GOTO            MOV_MOTOR4
                        BCF             PORTA,7
                        GOTO            FIN

MOV_MOTOR4:             BSF             PORTA,7
                        GOTO            EN_RANGO4                       



;---------------------TIEMPOS--------------
T25MS:                  MOVLW           .3   ;VAR1
                        MOVWF           0X64
                        MOVLW           .47   ;VAR2
                        MOVWF           0X65
                        MOVLW           .25   ;VAR3
                        MOVWF           0X66
                        CALL            ST3V
                        RETURN

FIN:                    GOTO            $
                        INCLUDE         <SUBTIEMPO.ASM>
                        END




;;PRACTICA 2 
;;AL PRESIONAR PB0, SE ALMACENA DATO 1 Y SE IMPRIME EN C
;;AL PRESIONAR PB0, SE ALMACENA DATO 2 Y SE IMPRIME EN C
;;DESPUES SE ESPERA HASTA QUE SE PRESIONE PB0 Y DESPUES DE REALIZA LUCES
;        
;        
;                        INCLUDE         <ENCABEZADO.INC>        ;B1
;                        CLRF            TRISC                   ;SALIDAS DATOS 
;                        CLRF            TRISA                   ;SALIDAS MOTORES   
;                          
;
;                        
;
;                        BCF             STATUS,RP0              ;BANCO 0
;
;
;DATO_1                  EQU             0X21            
;DATO_2                  EQU             0X22            
;
;
;DATO1:                  PUSH_ANTIR      PORTB,0             ;PRESIONAR PB0 PARA DATO 1
;
;                        MOVF            PORTD,W             ;GUARDA EL VALOR DE D EN W
;                        MOVWF           DATO_1              ;GUARDA EL VALOR DE W EN 0X21 (DATO_1)
;                        MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC 
;
;
;
;;DATO2:                  PUSH_ANTIR      PORTB,0             ;PRESIONAR PB0 PARA DATO 2
;;
;;                        MOVF            PORTD,W             ;GUARDA EL VALOR DE D EN W
;;                        MOVWF           DATO_2              ;GUARDA EL VALOR DE W EN 0X22 (DATO_2)
;;                        MOVWF           PORTC               ;GUARDA EL VALOR DE W EN PORTC
;                        EN_RANGO1       .60,PORTB1
;                        BTFSS            STATUS,C   
;                        EN_RANGO1       .120,PORTB2
;                        EN_RANGO1       .180,PORTB3
;
;CASO1:                  MOVF            DATO_1,W              ;0<= dato <= 60
;                        SUBLW           .60
;                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 60)
;                        GOTO            CASO2               ;SI    
;                        GOTO            EN_RANGO1
;
;EN_RANGO1:              BTFSS           PORTB,1             ;ENVIA 1 CUANDO DETECTA IMAN 
;                        GOTO            MOV_MOTOR1
;                        BCF             PORTA,7
;                        GOTO            FIN
;
;MOV_MOTOR1:              BSF             PORTA,7
;                        GOTO            EN_RANGO1
;
;
;CASO2:                  MOVF            DATO_1,W            ;61 <= DATO1 <= 120
;                        SUBLW           .120
;                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 120)
;                        GOTO            CASO3               ;SI    
;                        GOTO            EN_RANGO2
;
;EN_RANGO2:              BTFSS           PORTB,2             ;ENVIA 1 CUANDO DETECTA IMAN 
;                        GOTO            MOV_MOTOR2
;                        BCF             PORTA,7
;                        GOTO            FIN
;
;MOV_MOTOR2:             BSF             PORTA,7
;                        GOTO            EN_RANGO2
;
;
;CASO3:                  MOVF            DATO_1,W            ;121 <= DATO1 <= 180
;                        SUBLW           .180
;                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 180)
;                        GOTO            CASO4                 ;SI    
;                        GOTO            EN_RANGO3
;
;EN_RANGO3:              BTFSS           PORTB,3             ;ENVIA 1 CUANDO DETECTA IMAN 
;                        GOTO            MOV_MOTOR3
;                        BCF             PORTA,7
;                        GOTO            FIN
;
;MOV_MOTOR3:             BSF             PORTA,7
;                        GOTO            EN_RANGO3
;
;
;CASO4:                  MOVF            DATO_1,W            ;181 <= DATO1 <= 255
;                        SUBLW           .255
;                        BTFSS           STATUS,C            ;ES NEGATIVO? (MAYOR A 255)
;                        GOTO            FIN                 ;SI    
;                        GOTO            EN_RANGO4
;
;EN_RANGO4:              BTFSS           PORTB,4             ;ENVIA 1 CUANDO DETECTA IMAN 
;                        GOTO            MOV_MOTOR4
;                        BCF             PORTA,7
;                        GOTO            FIN
;
;MOV_MOTOR4:             BSF             PORTA,7
;                        GOTO            EN_RANGO4                       
;
;
;
;
;
;
;
;
;;---------------------TIEMPOS--------------
;T25MS:                  MOVLW           .3   ;VAR1
;                        MOVWF           0X64
;                        MOVLW           .47   ;VAR2
;                        MOVWF           0X65
;                        MOVLW           .25   ;VAR3
;                        MOVWF           0X66
;                        CALL            ST3V
;                        RETURN
;
;FIN:                    GOTO            $
;                        INCLUDE         <SUBTIEMPO.ASM>
;                        END
;
;
;
;
;