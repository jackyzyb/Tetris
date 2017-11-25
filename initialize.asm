
#include <P18F4520.INC>
#include <global_var_declare.inc>

    
  
    
    global	INITIALIZE
code
    
INITIALIZE
    setf    TRISB	    ; initialize I/O
    clrf    TRISC
    clrf    TRISD
    clrf    PORTC
    clrf    PORTD
    MOVLW   0X0F
    MOVWF   ADCON1
    
    BCF INTCON,INT0IF	    ; initialize INT
    BSF INTCON,INT0IE
    BCF INTCON2,INTEDG0
    BSF INTCON,GIE
    
    clrf    KEY_left	    ; initialize global variables
    clrf    KEY_right
    clrf    KEY_down
    clrf    KEY_shape
	
	movlw 0x10    ;initialize led matrix
	movwf column  
	movlw 0x3
	movwf led_loc
	lfsr 0,background
	
	movlw 0x0
	movwf TBLPTRU
	movlw 0x3
	movwf TBLPTRH
	movlw 0x0
	movwf TBLPTRL
	
	movlw d'10'
	movwf max_count
	
    return
end