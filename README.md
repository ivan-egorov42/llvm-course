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
