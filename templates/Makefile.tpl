IVERILOG = iverilog
VVP      = vvp
GTKWAVE  = gtkwave
VERILATOR= verilator

RTL_DIR  = rtl
TB_DIR   = tb
TEST_DIR = test
LOG_DIR  = logs
BUILD    = build
WAVES    = waves

RTL_SRCS  = $(wildcard $(RTL_DIR)/*.v)
TB_SRCS   = $(wildcard $(TB_DIR)/*_tb.v)
TEST_SRCS = $(wildcard $(TEST_DIR)/*.v)

SIM_OUT   = $(BUILD)/sim.out
IV_FLAGS  = -g2001

all: sim show-logs

sim: $(SIM_OUT)
	$(VVP) $(SIM_OUT)

$(SIM_OUT): $(RTL_SRCS) $(TB_SRCS) $(TEST_SRCS)
	mkdir -p $(BUILD) $(LOG_DIR)
	$(IVERILOG) $(IV_FLAGS) -o $(SIM_OUT) $(RTL_SRCS) $(TB_SRCS) $(TEST_SRCS)

waves: sim
	$(GTKWAVE) $(WAVES)/dump.vcd

lint:
	$(VERILATOR) --lint-only -Wall $(RTL_SRCS)

clean:
	rm -rf $(BUILD) $(WAVES)

show-logs:
	@echo "===== TEST LOGS ====="
	@ls $(LOG_DIR)/*.log >/dev/null 2>&1 && \
	for f in $(LOG_DIR)/*.log; do \
		echo "---- $$f ----"; \
		cat $$f; \
	done || echo "(no logs found)"

.PHONY: all sim waves lint clean
