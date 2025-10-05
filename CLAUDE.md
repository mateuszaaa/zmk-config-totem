# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a ZMK firmware configuration repository for the TOTEM split keyboard - a 38-key column-staggered split keyboard designed for use with SEEED XIAO BLE or RP2040 microcontrollers.

## Build System

### Building Firmware

The firmware is built automatically via GitHub Actions on push, pull request, or manual workflow dispatch. The build workflow is defined in `.github/workflows/build.yml` and uses ZMK's official build action.

To trigger a manual build:
- Push changes to the repository
- Or navigate to the "Actions" tab on GitHub and manually trigger the workflow

The build produces firmware files in `firmware.zip`:
- `totem_left-seeeduino_xiao_ble-zmk.uf2` (left half)
- `totem_right-seeeduino_xiao_ble-zmk.uf2` (right half)

### Build Configuration

- `build.yaml`: Specifies build targets for both keyboard halves with the seeeduino_xiao_ble board
- `config/west.yml`: West manifest pointing to the ZMK firmware repository (main branch)

## Repository Structure

### Key Configuration Files

- `config/totem.keymap`: Main keymap configuration (layers, combos, macros, behaviors)
- `config/totem.conf`: Global ZMK configuration settings (currently minimal)
- `config/boards/shields/totem/`: Shield definition files
  - `totem.dtsi`: Device tree include with common definitions
  - `totem.zmk.yml`: Shield metadata
  - `totem_left.overlay`, `totem_right.overlay`: Side-specific device tree overlays
  - `totem_left.conf`, `totem_right.conf`: Side-specific configurations
  - `Kconfig.defconfig`, `Kconfig.shield`: Kconfig definitions

### Keymap Architecture

The keymap is organized into 4 layers:
- **BASE (0)**: Colemak-DH layout with home row mods (GACS on left, SCAG on right)
- **NAV (1)**: Navigation layer with arrows, page up/down, numpad, and brackets
- **SYM (2)**: Symbol layer with special characters, international characters (Ä, Ö, Ü, ß), currency symbols, and media controls
- **ADJ (3)**: Adjustment layer with system controls (reset, bootloader), Bluetooth management, output toggle, and function keys

Layer access is controlled via layer-tap behaviors on the thumb cluster keys.

### Custom Behaviors

- **Mod-tap configuration** (`config/totem.keymap:24-29`):
  - Quick-tap: 100ms
  - Tapping term: 170ms
  - Flavor: tap-preferred with global-quick-tap

- **Combos** (`config/totem.keymap:32-39`):
  - Positions 0+1 → ESC (50ms timeout)

- **Macros** (`config/totem.keymap:41-53`):
  - `gif`: Types "#gif" (Shift+2 followed by "gif")

## Flashing Firmware

1. Download `firmware.zip` from GitHub Actions
2. Unzip the archive
3. For each half:
   - Connect the keyboard half via USB
   - Press reset button twice to enter bootloader mode
   - Keyboard appears as mass storage device
   - Drag and drop the corresponding `.uf2` file to the device

## Development Workflow

1. Edit `config/totem.keymap` to modify keymap
2. Push changes to trigger GitHub Actions build
3. Download firmware from Actions tab
4. Flash both halves with new firmware

## ZMK Documentation

- Keycodes: https://zmk.dev/docs/codes/
- Behaviors: https://zmk.dev/docs/behaviors/
- Configuration: https://zmk.dev/docs/config/
