ROOT_DIR := $(shell git rev-parse --show-toplevel)

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
WAVES = 1

MODULE_V = synchronizer

# TOPLEVEL is the name of the toplevel module file
TOPLEVEL = ${MODULE_V}

VERILOG_SOURCES += ${ROOT_DIR}/src/${MODULE_V}/rtl/${MODULE_V}.v

# MODULE is the basename of the Python test file
MODULE = ${MODULE_V}

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

logs:
	$(shell gtkwave sim_build/${MODULE_V}.fst)


