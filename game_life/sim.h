#ifndef SIM_H
#define SIM_H
#define SIM_X_SIZE 800
#define SIM_Y_SIZE 600

extern void simSetPixels(unsigned *nextGen);
extern void simFlush();
extern unsigned simRand();
extern void simInit();
#endif