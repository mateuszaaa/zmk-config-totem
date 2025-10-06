# Makefile for building TOTEM keyboard firmware locally

# Configuration
BOARD := seeeduino_xiao_ble
SHIELD_LEFT := totem_left
SHIELD_RIGHT := totem_right
SHIELD_LEFT_RESET := settings_reset
SHIELD_RIGHT_RESET := settings_reset
ZMK_APP := zmk/app
BUILD_DIR := build
CONFIG_DIR := $(shell pwd)/config

# Targets
.PHONY: all left right clean help

all: left right

reset: reset-left reset-right

left:
	@echo "Building left half..."
	cd $(ZMK_APP) && west build -d $(BUILD_DIR)/left -b $(BOARD) -- -DSHIELD=$(SHIELD_LEFT) -DZMK_CONFIG="$(CONFIG_DIR)"
	@echo "Left half built: $(ZMK_APP)/$(BUILD_DIR)/left/zephyr/zmk.uf2"

right:
	@echo "Building right half..."
	cd $(ZMK_APP) && west build -d $(BUILD_DIR)/right -b $(BOARD) -- -DSHIELD=$(SHIELD_RIGHT) -DZMK_CONFIG="$(CONFIG_DIR)"
	@echo "Right half built: $(ZMK_APP)/$(BUILD_DIR)/right/zephyr/zmk.uf2"

reset-right:
	@echo "Building right half..."
	cd $(ZMK_APP) && west build -d $(BUILD_DIR)/right -b $(BOARD) -- -DSHIELD=$(SHIELD_RIGHT_RESET) -DZMK_CONFIG="$(CONFIG_DIR)"
	@echo "Right half built: $(ZMK_APP)/$(BUILD_DIR)/right/zephyr/zmk.uf2"

reset-left:
	@echo "Building left half..."
	cd $(ZMK_APP) && west build -d $(BUILD_DIR)/left -b $(BOARD) -- -DSHIELD=$(SHIELD_LEFT_RESET) -DZMK_CONFIG="$(CONFIG_DIR)"
	@echo "Left half built: $(ZMK_APP)/$(BUILD_DIR)/left/zephyr/zmk.uf2"


clean:
	@echo "Cleaning build directories..."
	rm -rf $(ZMK_APP)/$(BUILD_DIR)/left
	rm -rf $(ZMK_APP)/$(BUILD_DIR)/right
	@echo "Clean complete"

help:
	@echo "TOTEM Keyboard Firmware Build"
	@echo ""
	@echo "Targets:"
	@echo "  all    - Build firmware for both left and right halves (default)"
	@echo "  left   - Build firmware for left half only"
	@echo "  right  - Build firmware for right half only"
	@echo "  clean  - Remove build directories"
	@echo "  help   - Show this help message"
	@echo ""
	@echo "Prerequisites:"
	@echo "  - Run 'west init -l config && west update' first"
	@echo "  - Ensure west toolchain is installed"
