;display the data in Led matrix

#include <P18F4520.INC>
#include <global_var_declare.inc>


global	DISPLAY

code


DISPLAY:
		movf led_loc,w
		movf PLUSW0,w     ;background[led_loc]
		movwf led_out
		movf y,w
		subwf led_loc,w
		bn out            ;if led_loc-y<0
		sublw 0x3
		bn out            ;if led_loc-y>3
		sublw 0x3         ;w=led_loc-y
		lfsr 1,block_data
		movf PLUSW1,w    ;block_data[led_loc-y]
		iorwf led_out,f
out:	clrf PORTD
		movff led_out,PORTC
		movff column,PORTD
		incf led_loc,f
		incf column,f
		movf column,w
		xorlw 0x10
		bnz led1
		movlw 0x3
		movwf led_loc
		bra exit_display
led1:	movf column,w
		xorlw 0x18
		bnz exit_display
		movlw 0x8
		movwf column
exit_display
		return
	
end