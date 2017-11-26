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
		temp1
		temp2
		temp3
		temp4
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
	decf x,f
	bn check_right
	call backup
	lfsr 1,block_data
	rlncf POSTINC1,f 
	rlncf POSTINC1,f 
	rlncf POSTINC1,f 
	rlncf POSTINC1,f 
	call CHECK
	bnz check_right
	incf x,f
	call restore
check_right:
	movf KEY_right,w      ;check if press right
	bz check_shape
	clrf KEY_right
	incf x,f
	call backup
	lfsr 1,block_data
	bcf STATUS,C
	rrcf POSTINC1,f
	bc back
	rrcf POSTINC1,f
	bc back
	rrcf POSTINC1,f
	bc back
	rrcf POSTINC1,f
	bc back
	call CHECK
	bnz check_shape
back:
	decf x,f
	call restore
check_shape:
	movf KEY_shape,w       ;check if press rotate
	bz check_down
	clrf KEY_shape
	movlw 0x4
	addwf shape_number,f
	movlw 0xF
	andwf shape_number,f
	call backup
	movff TBLPTRL,temp1
	movf shape_number,w
	addwf TBLPTRL,f
	lfsr 1,block_data
	movlw 0x4
	movwf temp2
loop3:
	TBLRD*+
	movff TABLAT,temp3
	movff x,temp4
	bz loop4_out
loop4:
	movlw 0x1
	andwf temp3,w
	bnz turn_back
	rrncf temp3,f
	decf temp4,f 
	bnz loop4
loop4_out:
	movff temp3,POSTINC1
	decf temp2,f
	bnz loop3
	movff temp1,TBLPTRL
	call CHECK
	bnz check_down
turn_back:
	movff temp1,TBLPTRL
	movlw -d'4'
	addwf shape_number,f
	movlw 0xF
	andwf shape_number,f 
	call restore
check_down:
	movf KEY_down,w        ;check if press down
	bnz fall_down 
	movf down_count1,w
	bnz exit
	movlw d'100'
	movwf down_count1
	movf down_count2,w
	bnz exit
fall_down:
	clrf KEY_down
	movlw d'100'
	movwf down_count1
	movlw d'6'
	movwf down_count2
	incf y,f 
	call CHECK
	bnz exit
	decf y,f 
	call DELETE
	goto loop1
	
exit:
	decf down_count1,f
	bnz led_display
	decf down_count2,f
led_display:
	call DISPLAY
	call DELAY
	goto loop2

game_over:
	goto game_over
	

backup:
	lfsr 1,block_data
	lfsr 2,block_temp
	movff POSTINC1,POSTINC2
 	movff POSTINC1,POSTINC2
	movff POSTINC1,POSTINC2
	movff POSTINC1,POSTINC2
	return
	
restore:
	lfsr 1,block_data
	lfsr 2,block_temp
	movff POSTINC2,POSTINC1
	movff POSTINC2,POSTINC1
	movff POSTINC2,POSTINC1
	movff POSTINC2,POSTINC1
	return


org 0x300
Tetris_table:
;I-type
db b'00000000',b'00000000',b'00000000',b'11110000'       
db b'10000000',b'10000000',b'10000000',b'10000000'
db b'00000000',b'00000000',b'00000000',b'11110000'
db b'10000000',b'10000000',b'10000000',b'10000000'
;L-type
db b'00000000',b'10000000',b'10000000',b'11000000'
db b'00000000',b'00000000',b'11100000',b'10000000'
db b'00000000',b'11000000',b'01000000',b'01000000'
db b'00000000',b'00000000',b'00100000',b'11100000'
;J-type
db b'00000000',b'01000000',b'01000000',b'11000000'
db b'00000000',b'00000000',b'10000000',b'11100000'
db b'00000000',b'11000000',b'10000000',b'10000000'
db b'00000000',b'00000000',b'11100000',b'00100000'
;S-type
db b'00000000',b'00000000',b'01100000',b'11000000'
db b'00000000',b'10000000',b'11000000',b'01000000'
db b'00000000',b'00000000',b'01100000',b'11000000'
db b'00000000',b'10000000',b'11000000',b'01000000'
;Z-type
db b'00000000',b'00000000',b'11000000',b'01100000'
db b'00000000',b'01000000',b'11000000',b'10000000'
db b'00000000',b'00000000',b'11000000',b'01100000'
db b'00000000',b'01000000',b'11000000',b'10000000'
;T-type
db b'00000000',b'00000000',b'11100000',b'01000000'
db b'00000000',b'01000000',b'11000000',b'01000000'
db b'00000000',b'00000000',b'01000000',b'11100000'
db b'00000000',b'10000000',b'11000000',b'10000000'
;#-type
db b'00000000',b'00000000',b'11000000',b'11000000'
db b'00000000',b'00000000',b'11000000',b'11000000'
db b'00000000',b'00000000',b'11000000',b'11000000'
db b'00000000',b'00000000',b'11000000',b'11000000'

	
end
		
		