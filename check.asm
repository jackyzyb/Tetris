#include<P18F4520.INC>
#include<global_var_declare.inc>

temp1 EQU 0x71
temp2 EQU 0x72
temp3 EQU 0x73	

global CHECK

code
CHECK:
	movf y,w
	xorlw 0x10
	bz out0
	movf TBLPTRL,w
	movwf temp1
	addwf shape_number,w
	movwf TBLPTRL
	movff y,temp2
	movlw 0x3
	movwf temp3
	addwf temp2,f
	addwf TBLPTRL,f
loop	movf PLUSW0,w
		decf temp2,f
		TBLRD*-
		andwf TABLAT,w
		bnz out0
		decf temp3,f
		bnn loop
	movlw 0x1
	return
out0:
	movlw 0x0
	return
end
