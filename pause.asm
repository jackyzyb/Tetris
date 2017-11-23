#include <global_var_declare.inc>
#include <P18F4520.INC>
    
    global	PAUSE
   
    code
    PAUSE
	BCF INTCON,INT0IF
	PAUSE_LOOP:
	btfss	PORTB,4	    ; press pin 5 (PORTB, 4) to skip from pause
	return
	call	delay
	goto	PAUSE_LOOP
    
    
    delay:
    MOVLW   D'100'
    MOVWF   1
    back        MOVLW   D'0'
    MOVWF   2
    here        NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    decf  2, F
    BNZ   here
    decf  1, F
    BNZ  back
    return
    
    end