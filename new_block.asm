#include<P18F4520.INC>
#include<global_var_declare.inc>

temp EQU 0x70
global NEW_BLOCK

extern RANDOM

code
NEW_BLOCK:
	call RANDOM
	mullw 0x10
	movff PRODL,TBLPTRL	
	movlw 0x2
	movwf x      ;x=2
	clrf y       ;y=0
	clrf shape_number ;shape_number=0 
	lfsr 1,block_data
	movlw 0x4
	movwf temp
loop:	TBLRD*+
		movff TABLAT,INDF1
		rrncf INDF1,f
		rrncf POSTINC1,f
		decf temp,f
		bnz loop
	movlw -d'4'
	addwf TBLPTRL
	return
end