
    ; global variables declare
cblock 0x80
	KEY_left
	KEY_right
	KEY_down
	KEY_shape
	KEY_count
	x            ;times of shift right
	y            ;location of the block
	type_number  ;type of block
	shape_number ;shape of block
	background:d'19'
	led_loc
	column
	led_out
	max_count
endc