#include <global_var_declare.inc>
#include <P18F4520.INC>
    
    global	PAUSE
	extern DISPLAY
	temp	equ	0x31
	extern DELAY
    code
    PAUSE
	BCF INTCON,INT0IF
	clrf	temp
	PAUSE_LOOP:
	btfss	PORTB,4	    ; press pin 5 (PORTB, 4) to skip from pause
	return
	call 	DISPLAY
	call	DELAY
	goto	PAUSE_LOOP
    
    end