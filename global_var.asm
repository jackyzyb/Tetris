  
 udata	0x100	; Outside accessing bank, need to set BSR to 0x1 to access
    KEY_left	res	1
    KEY_right   res	1
    KEY_down	res	1
    KEY_shape	res	1
    key_count	res	1
	
	
global	KEY_left, KEY_right, KEY_down, KEY_shape, key_count

end