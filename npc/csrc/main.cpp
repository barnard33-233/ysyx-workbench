#include <cstdlib>
#include <stdio.h>
#include <stdlib.h>
#include <random>
#include <assert.h>
#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <nvboard.h>

#define STEPS 10000

void nvboard_bind_all_pins(Vtop* top);

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp -> commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};

    VerilatedVcdC* tfp = new VerilatedVcdC;
    contextp->traceEverOn(true);
    top->trace(tfp, 0);
    tfp->open("wave.vcd");
    nvboard_bind_all_pins(top);
    nvboard_init();

    for (int i = 0; !contextp->gotFinish(); i++){
        top->eval();
        nvboard_update();
        // tfp->dump(contextp->time());
        // so many outputs.
        contextp->timeInc(1);
    }
    nvboard_quit();
    printf("--finish--\n");
    delete top;
    tfp->close();
    delete contextp;
    return 0;
}
