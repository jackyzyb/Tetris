
#include <P18F4520.INC>
#include <global_var_declare.inc>

temp EQU 0x30
  
    
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
	lfsr 1,block_data
	lfsr 2,block_temp
	movlw 0x12
loop:	clrf PLUSW0
		addlw -d'1'
		bnn loop
	
	movlw 0x0
	movwf TBLPTRU
	movlw 0x3
	movwf TBLPTRH
	movlw 0x0
	movwf TBLPTRL
	
	movlw d'100'
	movwf down_count1
	movlw d'6'
	movwf down_count2
	movlw 0x0
	movwf random_seed
	
RAN_SEED:
	incf random_seed,f
	movf	0x31,f
	bz		NEXT
	btfss PORTB,4
	return
	goto RAN_SEED
NEXT:
	btfss PORTB,4
	goto	RAN_SEED
	setf	0x31
	goto	RAN_SEED
	
    return
end