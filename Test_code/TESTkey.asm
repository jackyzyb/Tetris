LIST	P=18F4520 
#include <P18F4520.INC>
#include <names_declare.inc>
#include <global_var_declare.inc>
    CONFIG  OSC = XT
    CONFIG  WDT = OFF
    CONFIG  LVP = OFF
    
; function declare 
    extern	INITIALIZE
    extern	KEY
   
; temp
    cblock	0x10
		delay_h,delay_l,delay_u
		endc
    

org 0x000
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    
    goto MAIN
  
org 0x100
    MAIN:
    ; main codes here
    call    INITIALIZE
    
    movlw   b'00000001'
    movwf   PORTC
    LOOP:
	call	KEY
	movf	KEY_left,f
	bz	NEXT_R
	incf	PORTC,f
	clrf	KEY_left
	NEXT_R:
        movf	KEY_right,f
	bz	NEXT_D
	decf	PORTC,f
	clrf	KEY_right
	NEXT_D:
        movf	KEY_down,f
	bz	NEXT_S
	incf	PORTC,f
	clrf	KEY_down
	NEXT_S:
        movf	KEY_shape,f
	bz	NEXT
	incf	PORTC,f
	clrf	KEY_shape
	NEXT:
	;call	DELAY
	goto	LOOP

	
	
DELAY
		movlw d'40'
		movwf delay_h
delay1:	movlw d'0'
		movwf delay_l
delay2:	movlw d'0'
		movwf delay_u
delay3:	decf delay_u,f
		bnz delay3
		decf delay_l,f
		bnz delay2
		decf delay_h,f
		bnz delay1
		return
	
end
		
		