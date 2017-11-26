#include<P18F4520.INC>
#include<global_var_declare.inc>

global DELAY
cblock 0x60
	delay_u,delay_h,delay_l
endc
code
DELAY:
		movlw d'4'
		movwf delay_h
delay1:	movlw d'10'
		movwf delay_l
delay2:	movlw d'10'
		movwf delay_u
delay3:	decf delay_u,f
		bnz delay3
		decf delay_l,f
		bnz delay2
		decf delay_h,f
		bnz delay1
		return
end