#include<P18F4520.INC>
#include<global_var_declare.inc>

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
	return
end