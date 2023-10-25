# llvm-course 2023-2024
## Game of life
1. Running
```
cd game_life
g++ -c life.c sim.c
g++ life.o sim.o -o game -g -lsfml-graphics -lsfml-window -lsfml-system
./game
```
2. Game

![image](https://github.com/ivan-egorov42/llvm-course/assets/104271817/ce412a22-8430-4996-9700-068789194d94)

## Get stats about instructions
1. To get stats about instructions you can instrument game via llvm pass by running:
```
bash instrumentation.sh
./a.out
```
2. Pass will count number of uses of each instruction in runtime:
```
add 23755460
alloca 9120119
bitcast 9601956
br 50541370
call 13260967
getelementptr 17997097
icmp 37894482
invoke 480011
load 56812374
mul 7916999
ptrtoint 24
ret 4800090
sdiv 12
store 27954605
sub 1828612
switch 1828597
trunc 1
uitofp 1920000
urem 480000
zext 9837000
```
