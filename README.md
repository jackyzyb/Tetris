# Tetris 
* 对8个按键（0-7）：
    * 0: 暂停. 1:保留。   2:保留。    3:左移。 4:开始。    5:旋转。  6:下降。   7:右移

## 关于多文件
* 函数`example_func`在各自的 .asm 文件写好，里面声明`global examble_func`. 然后在`func_declare.inc` 中声明`extern example_func`. 这样只需要在主文件中`#include <func_declare.inc>` 即可直接使用子函数。
* 关于全局变量，为了方便统一，我们统一在`global_var_declare.inc` 中声明全局变量。在`global_var.asm` 中定义变量。然后只需要在各个`asm`文件中`#include <global_var.inc>` 即可直接使用。
* 如果有关于某全局变量`example_var`还有`unidentified symbol`的错误，再专门在 unidentified 的文件里加上`extern example_var` 即可
* 为了避免冲突，全局变量从0x80 开始 
