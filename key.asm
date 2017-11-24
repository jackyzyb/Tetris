; use PORTB as keys action input port
; pin 0~2 reserve for interupt
; pin 3: move left
; pin 7: move right
; pin 6: move down
; pin 5: rotate
    
; to detect key responses in main.asm, just check whether the global varibals (KEY_left...)
; 0 means nothing, non zero means there is a signal. (don't forget to set the corresponding global variables to 0 again)
    

#include <P18F4520.INC>
#include "global_var_declare.inc"
extern	random_seed
key_response_count_max equ 0x5
 
cblock	0x20	  
    flag_l
    count_l
    flag_r
    count_r
    flag_d
    count_d
    flag_s
    count_s
endc

global	KEY

code
 
KEY
    
KEY_LEFT_DETECT:
    btfss   PORTB, 3
    bra	    PIN_ACT_LEFT
	movlw   key_response_count_max
	movwf   count_l
	clrf    flag_l
	bra	KEY_RIGHT_DETECT
	
    PIN_ACT_LEFT:
	movlw	d'11'
	addwf	random_seed,f
	decf	count_l,f
	bnz	KEY_RIGHT_DETECT
	movf	flag_l,f
	bnz	KEY_RIGHT_DETECT
	setf	KEY_left
	setf	flag_l
	
	

KEY_RIGHT_DETECT:
    btfss   PORTB, 7
    bra	    PIN_ACT_RIGHT
	movlw   key_response_count_max
	movwf   count_r
	clrf    flag_r
	bra	KEY_DOWN_DETECT
	
    PIN_ACT_RIGHT:
	movlw	d'13'
	addwf	random_seed,f
	decf	count_r,f
	bnz	KEY_DOWN_DETECT
	movf	flag_r,f
	bnz	KEY_DOWN_DETECT
	setf	KEY_right
	setf	flag_r
	
	
	
KEY_DOWN_DETECT:
    btfss   PORTB, 6
    bra	    PIN_ACT_DOWN
	movlw   key_response_count_max
	movwf   count_d
	clrf    flag_d
	bra	KEY_ROTATE_DETECT
	
    PIN_ACT_DOWN:
	movlw	d'23'
	addwf	random_seed,f
	decf	count_d,f
	bnz	KEY_ROTATE_DETECT
	movf	flag_d,f
	bnz	KEY_ROTATE_DETECT
	setf	KEY_down
	setf	flag_d
	
	
KEY_ROTATE_DETECT:
    btfss   PORTB, 5
    bra	    PIN_ACT_ROTATE
	movlw   key_response_count_max
	movwf   count_s
	clrf    flag_s
	bra	FINISH
	
    PIN_ACT_ROTATE:
	movlw	d'43'
	addwf	random_seed,f
	decf	count_s,f
	bnz	FINISH
	movf	flag_s,f
	bnz	FINISH
	setf	KEY_shape
	setf	flag_s
	
	
FINISH:
    return
end
    


