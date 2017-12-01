#include<P18F4520.INC>
#include<global_var_declare.inc>

global DELAY

code
DELAY:
	movlw 0xFC
	movwf TMR0H
	movlw 0x00
	movwf TMR0L
	bcf INTCON,TMR0IF
	bsf T0CON,TMR0ON
loop:
	btfss INTCON,TMR0IF
	bra loop
	bcf T0CON,TMR0ON
	return
end