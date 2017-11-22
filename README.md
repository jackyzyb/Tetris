# Tetris
Tetris implemented on PIC18

## 关于多文件
* 函数`example_func`在各自的 .asm 文件写好，里面声明`global examble_func`. 然后在`func_declare.inc` 中声明`extern example_func`. 这样只需要在主文件中`#include <func_declare.inc>` 即可直接使用子函数。
* 关于全局变量，为了方便统一，我们统一在`global_var_declare.inc` 中声明全局变量。在`global_var.asm` 中定义变量。然后只需要在各个`asm`文件中`#include <global_var.inc>` 即可直接使用。
* 为了避免冲突，全局变量从0x100 开始 （BSR = 1）
