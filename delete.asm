#include<P18F4520.INC>
#include<global_var_declare.inc>

temp EQU 0x40
temp1 EQU 0x41
temp2 EQU 0x42
temp3 EQU 0x43
global DELETE

code
DELETE:
	movlw 0x4
	movwf temp
	lfsr 1,block_data
loop:
	movf y,w
	movf PLUSW0,w
	iorwf POSTINC1,w
	movwf temp1
	movf y,w
	movff temp1,PLUSW0
	incf y,f
	decf temp
	bnz loop
	movlw 0x3
	movwf temp
loop1:
	movf temp,w
	movf PLUSW0,w
	xorlw 0xFF
	bnz loop2_out
	lfsr 2,background
	movff temp,temp1
	decf temp1,w
	movwf temp2
loop2:
	movf temp2,w
	movff PLUSW2,temp3
	movf temp1,w
	movff temp3,PLUSW0
	decf temp1,f
	decf temp2,f
	bnz loop2
	clrf INDF0
loop2_out:
	incf temp,f
	movlw 0x13
	xorwf temp,w
	bnz loop1
	return
end