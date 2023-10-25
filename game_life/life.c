#include "sim.h"
#define REPEAT_SIZE 1

void drawGen(unsigned *nextGen)
{
  simSetPixels(nextGen);
  simFlush();
}

int count_neighbors(unsigned y_origin, unsigned x_origin, unsigned *prevGen)
{
  int neighbors = 0;
  for (unsigned y_current = y_origin - 1; y_current <= y_origin + 1; ++y_current) {
    for (unsigned x_current = x_origin - 1; x_current <= x_origin + 1; ++x_current) {
      
      if (y_current < 0 || y_current >= SIM_Y_SIZE ||
        x_current < 0 || x_current >= SIM_X_SIZE)
        continue;

      if (y_current == y_origin && x_current == x_origin)
        continue;

      if (prevGen[y_current * SIM_X_SIZE + x_current]) {
          if (++neighbors > 3)
            return neighbors;
      }
    }
  }
  return neighbors;
}

void calcCell(int neighbors, unsigned y, unsigned x, unsigned *prevGen, unsigned *nextGen) {
  nextGen[y * SIM_X_SIZE + x] = prevGen[y * SIM_X_SIZE + x];
  // Any live cell with fewer than two live neighbors dies,
  // as if caused by under population.
  if (prevGen[y * SIM_X_SIZE + x] && neighbors < 2)
      nextGen[y * SIM_X_SIZE + x] = 0;

  // Any live cell with two or three live neighbors lives on
  if (prevGen[y * SIM_X_SIZE + x] && (neighbors == 2 || neighbors == 3))
      nextGen[y * SIM_X_SIZE + x] = 1;

  // Any live cell with more than three live neighbors dies,
  // as if by overpopulation.
  if (prevGen[y * SIM_X_SIZE + x] && neighbors > 3)
      nextGen[y * SIM_X_SIZE + x] = 0;

  // Any dead cell with exactly three live neighbors becomes a live cell,
  // as if by reproduction.
  if (!prevGen[y * SIM_X_SIZE + x] && neighbors == 3)
      nextGen[y * SIM_X_SIZE + x] = 1;
}

void calcGen(unsigned *nextGen, unsigned *prevGen)
{
	for (unsigned y = 0; y < SIM_Y_SIZE; ++y) {
        for (unsigned x = 0; x < SIM_X_SIZE; ++x) {
            calcCell(count_neighbors(y, x, prevGen), y, x, prevGen, nextGen);
        }
    }
}

int main()
{
  unsigned x = 0;
  unsigned y = 0;
  unsigned i = 0;
  unsigned gen1[SIM_Y_SIZE * SIM_X_SIZE];
  unsigned gen2[SIM_Y_SIZE * SIM_X_SIZE];
  unsigned *nextGen = gen1;
  unsigned *prevGen = gen2;

  for (y = 0; y < SIM_Y_SIZE; y++) {
    for (x = 0; x < SIM_X_SIZE; x++) {
      prevGen[y * SIM_X_SIZE + x] = simRand() % 2;
    }
  }

  simInit();
  drawGen(prevGen);

  for (i = 0; i < REPEAT_SIZE; i++) {
    calcGen(nextGen, prevGen);
    drawGen(nextGen);
    unsigned *tmp = prevGen;
    prevGen = nextGen;
    nextGen = tmp;
  }

  return 0;
}