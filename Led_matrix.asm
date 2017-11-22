LIST P=F4520
#include<P18F4520.INC>
CONFIG	OSC = XT
CONFIG	WDT = OFF
CONFIG	LVP = OFF
	ORG 0x0
	goto main
	cblock 0x100
		led_head:0x3
		led_data0:0x8
		led_data1:0x8
		column:0x1
		delay_u:0x1
		delay_h:0x1
		delay_l:0x1
		count:0x1
	endc

	ORG 0x100
main:	clrf TRISC   ;PORTC controls led data
		clrf PORTC
		clrf TRISD   ;PORTD controls column
		clrf PORTD
		lfsr 0,led_data0
		movlb 0x1
		movlw 0x10
		movwf count
init0:	movff count,POSTINC0
		decf count,f
		bnz init0

		movlw 0x8    ;initialization
		movwf column  
		lfsr 0,led_data1
loop:	call display
		call delay
		bra loop

display:
		movff column,PORTD
		movff POSTINC0,PORTC
		incf column,f
		movf column,w
		xorlw 0x10
		bnz led1
		lfsr 0,led_data0
		bra exit_display
led1	movf column,w
		xorlw 0x18
		bnz exit_display
		movlw 0x8
		movwf column
		lfsr 0,led_data1		
exit_display
		return


delay:	movlw d'0'
		movwf delay_h
delay1:	movlw d'0'
		movwf delay_l
delay2:	movlw d'2'
		movwf delay_u
delay3:	decf delay_u,f
		bnz delay3
		decf delay_l,f
		bnz delay2
		decf delay_h,f
		bnz delay1
		return
END
		
		