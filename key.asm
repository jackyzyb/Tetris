LIST	P=18F4520 
#include <P18F4520.INC>
#include <global_var.inc>
key_response_count_max equ d'100'
 

 
global	KEY
    
code

KEY:
    movlw   0x1
    movwf   BSR
    movf    key_response_count_max, w
    subwf   key_count, w, 1
    bz	    READY
    
READY:
    
    
    
end

