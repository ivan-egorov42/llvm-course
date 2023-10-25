clang++ llvm-pass-track.cpp -c -fPIC -I`llvm-config-12 --includedir` -o pass.o && 
clang++ pass.o -fPIC -shared -o libPass.so && 
clang++ log.cpp -c -o log.o &&
clang++ -Xclang -load -Xclang ./libPass.so log.o game_life/life.c game_life/sim.c -flegacy-pass-manager -lsfml-graphics -lsfml-window -lsfml-system -lstdc++ -O2