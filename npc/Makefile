TOPNAME = example
VERILATOR = verilator

# project source
VSRC = $(shell find $(abspath ./vsrc) -name "*.v")
CPPSRC = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")

BUILD_DIR = ./build
OBJDIR = ./build/obj_dir
VCD = $(BUILD_DIR)/wave.vcd

BIN = $(BUILD_DIR)/$(TOPNAME)

$(shell mkdir -p $(BUILD_DIR))

VFLAGS += -Wall --cc --exe --build --trace

all: sim

$(BIN): $(VSRC) $(CPPSRC)
	$(VERILATOR) $(VFLAGS) \
		$(CPPSRC) $(VSRC) \
		-Mdir $(OBJDIR) -o $(abspath $(BIN))

sim: $(VCD)
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	gtkwave $(VCD)

verilate: $(BIN)


$(VCD): $(BIN)
	$(BIN)

clean:
	rm -r $(BUILD_DIR)

.PHONY: clean verilate sim all

include ../Makefile
