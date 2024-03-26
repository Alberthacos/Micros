;Antirrebotes
;La oscilacion empieza hasta que se apriete el interruptor conectado a PE.0
;Que saque 0xF0 por el PC DURANTE 200 ms
;Que saque 0x0F por el PC DURANTE 200 ms
;y se repita la tarea de forma indefinida
        INCLUDE         <ENCABEZADO.INC>        ;B1
        CLRF            TRISC
        BCF             STATUS,RP0              ;B0

        BTFSS           PORTB,0
        GOTO            $-1
        CALL            T25MS
        BTFSC           PORTB,0
        GOTO            $-1
        CALL            T25MS

        MOVLW           0XF0      
        MOVWF           PORTC
        CALL            T200MS
        SWAPF           PORTC,F
        GOTO            $-2 

T25MS:  MOVLW           .3   ;VAR1
        MOVWF           0X64
        MOVLW           .47   ;VAR2
        MOVWF           0X65
        MOVLW           .25   ;VAR3
        MOVWF           0X66
        CALL            ST3V
        RETURN

T200MS: MOVLW           .243   ;VAR2
        MOVWF           0X61
        MOVLW           .117   ;VAR1
        MOVWF           0X62
        CALL            ST2V
        RETURN

        INCLUDE         <SUBTIEMPO.ASM>
        END
