# ACRL cf-firmware  [![Build Status](https://api.travis-ci.org/HovakimyanResearch/cf-firmware.svg)](https://travis-ci.org/HovakimyanResearch/cf-firmware)

This project contains the source code for the ACRL  cf-firmware.

## Workflow

If you are a contributor to this code. Please see
[this](https://github.com/HovakimyanResearch/cf-firmware/wiki/Workflow)
for how the workflow should be organized and pull requests created.

## Dependencies and Installation

You'll need to use either the [Crazyflie VM](https://wiki.bitcraze.io/projects:virtualmachine:index),
[the toolbelt](https://wiki.bitcraze.io/projects:dockerbuilderimage:index) or
install some ARM toolchain.

Click
[here](https://github.com/HovakimyanResearch/cf-firmware/wiki/Installation)
to find out how to install the toolchains.

## Compiling for each vehicle

### Crazyflie

Build with:
```bash
make VEH=CF
```
### Q2

This is the dafault build so just running "make" is enough or:
```bash
make VEH=Q2
```

### config.mk
To create custom build options create a file called config.mk in `tools/make`
and fill it with options. E.g.
```
# Q2 Flags
Q2_CFLAGS += -DENABLE_Q2_ARM
Q2_CFLAGS += -DSE3_COMPLEMENTARY_FILTER

# CF Flags
CF_CFLAGS += -DENABLE_L1
```
These flags get imported as macros during complilation based on the vehicle
selected. All available flags and their descriptions can be found in
`tools/make/config.mk.example`.

# Make targets:
```
all        : Shortcut for build
compile    : Compile cflie.hex. WARNING: Do NOT update version.c
build      : Update version.c and compile cflie.elf/hex
clean_o    : Clean only the Objects files, keep the executables (ie .elf, .hex)
clean      : Clean every compiled files
mrproper   : Clean every compiled files and the classical editors backup files

cload      : If the crazyflie-clients-python is placed on the same directory level and
             the Crazyradio/Crazyradio PA is inserted it will try to flash the firmware
             using the wireless bootloader.
flash      : Flash .elf using OpenOCD
halt       : Halt the target using OpenOCD
reset      : Reset the target using OpenOCD
openocd    : Launch OpenOCD
```

# Tips
* Use `cload` to quickly flash the crazyflie:
   ```
   make VEH=Q2 && make cload
   ```
   Install [crazyflie-clients-python](https://github.com/bitcraze/crazyflie-clients-python.git)
   to use this feature.
