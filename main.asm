LIST	P=18F4520 
#include <P18F4520.INC>
#include <global_var_declare.inc>
    CONFIG  OSC = XT
    CONFIG  WDT = OFF
    CONFIG  LVP = OFF
    
; function declare 
    extern INITIALIZE
    extern KEY, PAUSE
	extern DISPLAY
	extern CHECK
	extern DELETE
	extern DELAY
	extern NEW_BLOCK
	
; temp
    cblock	0x10
		down_count
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
    call INITIALIZE
loop1:
    call NEW_BLOCK
	call CHECK
	bz game_over
loop2:
	call KEY
	movf KEY_left,w      ;check if press left
	bz check_right
	clrf KEY_left
	incf x,f
	call CHECK
	bnz check_right
	decf x,f
check_right:
	movf KEY_right,w      ;check if press right
	bz check_shape
	clrf KEY_right
	decf x,f
	call CHECK
	bnz check_shape
	incf x,f
check_shape:
	movf KEY_shape,w       ;check if press rotate
	bz check_down
	clrf KEY_shape
	movlw 0x4
	addwf shape_number,f
	movlw 0xF
	andwf shape_number,f
	call CHECK
	bnz check_down
	movlw -d'4'
	addwf shape_number,f
	movlw 0xF
	andwf shape_number,f 
check_down:
	movf KEY_down,w        ;check if press down
	bnz fall_down 
	movf down_count,w
	xorwf max_count,w
	bnz exit
fall_down:
	clrf KEY_down
	clrf down_count
	incf y,f 
	call CHECK
	bnz exit
	decf y,f 
	call DELETE
	goto loop1
	
exit:
	incf down_count,f
	call DISPLAY
	call DELAY
	goto loop2

game_over:
	goto game_over
	
	

org 0x300
Tetris_table:
db b'00000000'       ;I-type
db b'00000000'
db b'00000000'
db b'11110000'

db b'10000000'
db b'10000000'
db b'10000000'
db b'10000000'

db b'00000000'
db b'00000000'
db b'00000000'
db b'11110000'
	
db b'10000000'
db b'10000000'
db b'10000000'
db b'10000000'

db b'00000000'      ;L-type
db b'10000000'
db b'10000000'
db b'11000000'

db b'00000000'
db b'00000000'
db b'11100000'
db b'10000000'

db b'00000000'
db b'11000000'
db b'01000000'
db b'01000000'

db b'00000000'
db b'00000000'
db b'00100000'
db b'11100000'

db b'00000000'       ;J-type
db b'01000000'
db b'01000000'
db b'11000000'


db b'00000000'
db b'00000000'
db b'10000000'
db b'11100000'

db b'00000000'
db b'11000000'
db b'10000000'
db b'10000000'

db b'00000000'
db b'00000000'
db b'11100000'
db b'00100000'

db b'00000000'       ;S-type
db b'00000000'
db b'01100000'
db b'11000000'


db b'00000000'
db b'10000000'
db b'11000000'
db b'01000000'

db b'00000000'
db b'00000000'
db b'01100000'
db b'11000000'

db b'00000000'
db b'10000000'
db b'11000000'
db b'01000000'

db b'00000000'       ;Z-type
db b'00000000'
db b'11000000'
db b'01100000'


db b'00000000'
db b'01000000'
db b'11000000'
db b'10000000'

db b'00000000'
db b'00000000'
db b'11000000'
db b'01100000'

db b'00000000'
db b'01000000'
db b'11000000'
db b'10000000'

db b'00000000'       ;T-type
db b'00000000'
db b'11100000'
db b'01000000'


db b'00000000'
db b'01000000'
db b'11000000'
db b'01000000'

db b'00000000'
db b'00000000'
db b'01000000'
db b'11100000'

db b'00000000'
db b'10000000'
db b'11000000'
db b'10000000'

db b'00000000'       ;#-type
db b'00000000'
db b'11000000'
db b'11000000'


db b'00000000'
db b'00000000'
db b'11000000'
db b'11000000'

db b'00000000'
db b'00000000'
db b'11000000'
db b'11000000'

db b'00000000'
db b'00000000'
db b'11000000'
db b'11000000'

	
end
		
		