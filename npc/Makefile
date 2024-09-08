TOPNAME = top
VERILATOR = verilator

# project source
NXDCSRC = constr/top.nxdc
VSRC = $(shell find $(abspath ./vsrc) -name "*.v")
CXXSRC = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
INC_PATH ?=

# outputs
BUILD_DIR = ./build
OBJDIR = ./build/obj_dir
VCD = wave.vcd
AUTO_BIND_SRC = $(abspath $(BUILD_DIR)/auto_bind.cpp)
CXXSRC += $(AUTO_BIND_SRC)
BIN = $(BUILD_DIR)/$(TOPNAME)

$(shell mkdir -p $(BUILD_DIR))

VFLAGS += -Wall --cc --exe --build --trace
CXXFLAGS += $(addprefix -I, $(INC_PATH))

# rules

default: verilate
	
all: sim

$(AUTO_BIND_SRC): $(NXDCSRC)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

include $(NVBOARD_HOME)/scripts/nvboard.mk

sim: $(VCD)
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	gtkwave $(VCD)

verilate: $(BIN)

bindsrc: $(AUTO_BIND_SRC)

run: $(BIN)
	$^

$(VCD): $(BIN)
	$^

$(BIN): $(VSRC) $(CXXSRC) $(NVBOARD_ARCHIVE)
	$(VERILATOR) $(VFLAGS)\
		--top-module $(TOPNAME)\
	    $^\
		$(addprefix -CFLAGS , $(CXXFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS))\
		-Mdir $(OBJDIR) -o $(abspath $(BIN))

clean:
	rm -r $(BUILD_DIR)

cleanall: nvboard-clean clean

.PHONY: sim default all clean cleanall verilate bindsrc run

include ../Makefile
