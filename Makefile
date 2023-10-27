CC=clang
CXX=clang++
CFLAGS=-lsfml-graphics -lsfml-window -lsfml-system -lstdc++ -O2

SOURCE=game_life/life.c
SOURCE_O=life.o sim.o
EXEC=game

INSTR_PATH=log.cpp
INSTR_O=log.o

GRAPHICS_PATH=game_life/sim.c
GRAPHICS_O=sim.o

PASS_SOURCE=llvm-pass-track.cpp
PASS_O=pass.o
PASS_SO=libPass.so
EXEC_PATH=execution_path.log

all: game

game:
	$(CXX) -c $(SOURCE) $(GRAPHICS_PATH)
	$(CXX) $(SOURCE_O) $(CFLAGS) -o $(EXEC)

pass:
	$(CXX) $(PASS_SOURCE) -c -fPIC -I`llvm-config-12 --includedir` -o $(PASS_O)
	$(CXX) $(PASS_O) -fPIC -shared -o $(PASS_SO)
	rm -rf $(PASS_O)

game-with-pass: pass
	$(CXX) $(INSTR_PATH) -c -o $(INSTR_O)
	$(CXX) $(GRAPHICS_PATH) -c -o $(GRAPHICS_O)
	$(CXX) -DINSTRUMENTATION -flegacy-pass-manager -Xclang -load -Xclang ./$(PASS_SO) $(INSTR_O) $(GRAPHICS_O) $(SOURCE) $(CFLAGS) -o $(EXEC)
	rm -rf $(INSTR_O) $(GRAPHICS_O)

clean:
	rm -rf $(EXEC) $(PASS_O) $(PASS_SO)