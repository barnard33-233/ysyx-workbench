#include <cstdlib>
#include <stdio.h>
#include <stdlib.h>
#include <random>
#include <assert.h>
#include "Vexample.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

#define STEPS 10

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp -> commandArgs(argc, argv);
    Vexample* top = new Vexample{contextp};

    VerilatedVcdC* tfp = new VerilatedVcdC;
    contextp->traceEverOn(true);
    top->trace(tfp, 0);
    tfp->open("wave.vcd");

    for (int i = 0; i < STEPS && !contextp->gotFinish(); i++){
        printf("step %d: ", i);
        int a = rand() & 1;
        int b = rand() & 1;
        top->a = a;
        top->b = b;
        top->eval();
        printf("a = %d, b = %d, f = %d\n", a, b, top->f);
        tfp->dump(contextp->time());
        contextp->timeInc(1);
        assert(top->f == (a ^ b));
    }
    printf("--finish--\n");
    delete top;
    tfp->close();
    delete contextp;
    return 0;
}
