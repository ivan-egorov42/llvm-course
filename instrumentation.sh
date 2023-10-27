clang++ llvm-pass-track.cpp -c -fPIC -I`llvm-config-12 --includedir` -o pass.o && 
clang++ pass.o -fPIC -shared -o libPass.so && 
clang++ log.cpp -c -o log.o -O2 &&
clang++ game_life/sim.c -c -o sim.o -O2 &&
clang++ -Xclang -load -Xclang ./libPass.so log.o sim.o game_life/life.c -flegacy-pass-manager -lsfml-graphics -lsfml-window -lsfml-system -lstdc++ -O2 -DINSTRUMENTATION