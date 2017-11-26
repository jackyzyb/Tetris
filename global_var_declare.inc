
    ; global variables declare
cblock 0x80
	KEY_left
	KEY_right
	KEY_down
	KEY_shape
	KEY_count
	x            ;times of shift right
	y            ;location of the block
	shape_number ;shape of block
	background:d'19'
	block_data:0x4
	block_temp:0x4
	led_loc
	column
	led_out
	down_count1
	down_count2
	random_seed
endc