LIST	P=18F4520 
#include <P18F4520.INC>
#include <names_declare.inc>
#include <global_var_declare.inc>
    CONFIG  OSC = XT
    CONFIG  WDT = OFF
    CONFIG  LVP = OFF
    
; function declare 
    extern	INITIALIZE
    extern	KEY, PAUSE, RANDOM
   
; temp
    cblock	0x10
		delay_h,delay_l,delay_u
		endc
    

org 0x000
    goto MAIN
  
    
    ORG 0x0008			; Interrupt, press pin 4 (start from pin0) to escape from pause
    BTFSC INTCON,INT0IF
    call PAUSE
    RETFIE
    
    
    
org 0x100
    MAIN:
		; main codes here
    call    INITIALIZE
    
    BEGIN:
	call	RANDOM	    ; generate a random number ranage from 0 to 6 in WREG
	 
	
	
	
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
		
		