//俄罗斯方块伪代码

main{
	initialization()               //初始化
	while(1){
		generate_random_number()   //产生随机数
		new_block()                //产生新的下落方块
		if(check()){
			while(1){
				key()                  //判断按键
				if(KEY_left==1){
					KEY_left = 0
					if(check())
						move_left()   //左移
				}                     
				if(KEY_right==1){                   //右移
					KEY_right=0
					if(check())
						move_right()   
				}
				if(KEY_shape==1){                   //改变形状
					KEY_shape=0
					if(check()) 
						change_shape() 
				}
				if((KEY_down==1)or(count_down==count_down_max)){   //下落
					KEY_down=0
					count_down=0
					if(check()) move_down()
					else{
						delete()              //判断是否需要消除
						break
					}
				}
				
				display()             //显示
				delay()
			}
		}
		else game_over()
	}
}
