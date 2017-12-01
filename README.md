# Tetris 
* 对8个按键（0-7）：
    * 0: 暂停. 1:保留。   2:保留。    3:右移。 4:开始。    5:下降。  6:旋转。   7:左移

## 关于多文件
* 函数`example_func`在各自的 .asm 文件写好，里面声明`global examble_func`， 然后在需要使用该函数的程序中声明`extern example_func`即可直接使用该函数。
* 关于全局变量，为了方便统一，我们统一在`global_var_declare.inc` 中声明全局变量，然后只需要在各个`asm`文件中`#include <global_var_declare.inc>` 即可直接使用。
* 如果有关于某全局变量`example_var`还有`unidentified symbol`的错误，再专门在 unidentified 的文件里加上`extern example_var` 即可
* 为了避免冲突，全局变量从0x80 开始 
* 使用环境MPLAB IDE v8.92，PIC18F4520
