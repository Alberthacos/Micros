SUBT1V      MACRO       VAR1
            MOVLW       VAR1        
            MOVWF       0X60
            CALL        ST1V
            ENDM
 ;-------------------------------------------
 SUBT2V     MACRO       VAR1,VAR2
            MOVLW       VAR2    
            MOVWF       0X61
            MOVLW       VAR1    
            MOVWF       0X62
            CALL        ST2V
            ENDM
;-------------------------------------------
SUBT3V      MACRO       VAR1,VAR2,VAR3
            MOVLW       VAR1    
            MOVWF       0X64
            MOVLW       VAR2    
            MOVWF       0X65
            MOVLW       VAR3    
            MOVWF       0X66
            CALL        ST3V
            ENDM
;-----------------------------------------
PUSH_ANTIR  MACRO   PUERTO,PIN
            BTFSS   PUERTO,PIN
            GOTO    $-1
            CALL    T25MS
            BTFSC   PUERTO,PIN
            GOTO    $-1
            CALL    T25MS
            ENDM
;----------------------------------
SUBT25MS    MACRO   
T25MS:      SUBT3V
            RETURN
            ENDM       
