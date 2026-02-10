SRC_DIR := src

# discover projects under src/ (directory names)
PROJECTS := $(patsubst $(SRC_DIR)/%,%,$(wildcard $(SRC_DIR)/*))
DEFAULT_PROJ := $(firstword $(PROJECTS))
PROJ ?= $(DEFAULT_PROJ)

# default toolchain (can be overridden in project-specific project.mk)
IVERILOG ?= iverilog
VVP      ?= vvp
GTKWAVE  ?= gtkwave
VERILATOR?= verilator
IV_FLAGS ?= -g2001

# per-project locations (relative to repo root)
PROJ_DIR := $(SRC_DIR)/$(PROJ)
RTL_DIR  := $(PROJ_DIR)/rtl
TB_DIR   := $(PROJ_DIR)/tb
TEST_DIR := $(PROJ_DIR)/test
LOG_DIR  := $(PROJ_DIR)/logs
BUILD    := $(PROJ_DIR)/build
WAVES    := $(PROJ_DIR)/waves

RTL_SRCS  := $(wildcard $(RTL_DIR)/*.v)
TB_SRCS   := $(wildcard $(TB_DIR)/*_tb.v)
TEST_SRCS := $(wildcard $(TEST_DIR)/*.v)

SIM_OUT   := $(BUILD)/sim.out

# allow per-project override file named project.mk inside the project dir
PROJECT_MK := $(PROJ_DIR)/project.mk
-include $(PROJECT_MK)

.PHONY: list all all-projects build sim waves lint clean show-logs new-proj

list:
	@echo $(PROJECTS)

# Run 'all' (build+sim+logs) for every project
all-projects:
	@for p in $(PROJECTS); do \
		echo "=== $$p ==="; \
		$(MAKE) PROJ=$$p all || exit 1; \
	done

all: sim show-logs

build: $(SIM_OUT)

sim: $(SIM_OUT)
	@echo "Running simulation for $(PROJ) -> $(SIM_OUT)"
	$(VVP) $(SIM_OUT)

$(SIM_OUT): $(RTL_SRCS) $(TB_SRCS) $(TEST_SRCS)
	@mkdir -p $(BUILD) $(LOG_DIR) $(WAVES)
	@echo "Compiling: $(PROJ)"
	$(IVERILOG) $(IV_FLAGS) -o $(SIM_OUT) $(RTL_SRCS) $(TB_SRCS) $(TEST_SRCS)

waves: sim
	$(GTKWAVE) $(WAVES)/dump.vcd

lint:
	$(VERILATOR) --lint-only -Wall $(RTL_SRCS)

clean:
	rm -rf $(BUILD) $(WAVES)

show-logs:
	@echo "===== TEST LOGS ($(PROJ)) ====="
	@ls $(LOG_DIR)/*.log >/dev/null 2>&1 && \
	for f in $(LOG_DIR)/*.log; do \
		echo "---- $$f ----"; \
		cat $$f; \
	done || echo "(no logs found)"

new-proj:
	@if [ -z "$(NAME)" ]; then \
	  echo "Usage: make new-proj NAME=<project>"; \
	  exit 1; \
	fi
	bash ./scripts/new_project.sh $(NAME)