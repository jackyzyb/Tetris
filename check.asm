#include<P18F4520.INC>
#include<global_var_declare.inc>

temp1 EQU 0x50
temp2 EQU 0x51

global CHECK

code
CHECK:
	movf y,w
	xorlw 0x10
	bz out0
	lfsr 1,block_data
	clrf temp1
	movf y,w
	movwf temp2
loop	movf temp2,w
		movf PLUSW0,w
		andwf POSTINC1,w
		bnz out0
		incf temp1,f
		incf temp2,f
		movlw 0x4
		xorwf temp1,w
		bnz loop
	movlw 0x1
	andlw 0x1
	return
out0:
	andlw 0x0
	return
end
