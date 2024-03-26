;OTRAS DIRECTCIVAS "DEFINE" Y "MACROS"
;UTILIZANDO  EL OSCILADOR DE 0XF0 A 0X0F CON TIEMPOS DE 200MS

                #DEFINE             PSALIDA         PORTD   
                INCLUDE             <ENCABEZADO.INC>
                CLRF                TRISD
                BCF                 STATUS,RP0               ;B0

                PUSH_ANTIR          PORTB,0

                MOVLW               0XF0
                MOVWF               PSALIDA
                SUBT3V              .11,.35,.73
                SWAPF               PORTD,F
                GOTO                $-2

T25MS:          SUBT3V              .3,.47,.25
                RETURN

                INCLUDE             <SUBTIEMPO.ASM>

                END