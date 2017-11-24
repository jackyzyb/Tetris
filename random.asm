#include <global_var_declare.inc>
#include <P18F4520.INC>
    
    global	RANDOM
    extern	random_seed
   
    code
    RANDOM	    ; generate a random number from 0 to 6
    movlw   d'157'
    xorwf   random_seed,f
    movlw   d'233'
    addwf   random_seed,f
    movlw   d'123'
    xorwf   random_seed,f
    movlw   d'7'
    andwf   random_seed,w  
    bz	    RANDOM
    addlw   0xff
    return
    
    end