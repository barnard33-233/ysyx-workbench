VERILATOR = verilator
VFLAGS = -Wall --cc --exe --build --trace
CPPSRC = $(wildcard csrc/*.cpp)
VSRC = vsrc/example.v
VCDSRC = wave.vcd
EXE = ./obj_dir/V$(basename $(notdir $(VSRC)))

all: sim

sim: verilate $(VCDSRC)
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	gtkwave $(VCDSRC)
	

verilate: $(VSRC) $(CPPSRC)
	$(VERILATOR) $(VFLAGS) $(CPPSRC) $(VSRC)

$(VCDSRC):
	$(EXE)

clean:
	rm -r ./obj_dir/
	rm $(VCDSRC)

.PHONY: clean

include ../Makefile
