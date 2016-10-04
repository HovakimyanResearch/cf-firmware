# ACRL cf-firmware  [![Build Status](https://api.travis-ci.org/HovakimyanResearch/cf-firmware.svg)](https://travis-ci.org/HovakimyanResearch/cf-firmware)

This project contains the source code for the ACRL  cf-firmware.

## Workflow

If you are a contributor to this code. Please see
[this](https://github.com/HovakimyanResearch/cf-firmware/wiki/Workflow)
for how the workflow should be organized and pull requests created.

#### General coding guidelines
* Make sure you use spaces (convert your tab characters to 2 spaces). *[One
  indent = 2 spaces]*. This is easy to set up in sublime, notepad++ or vim.
* Please make sure that there are not trailing whitespaces in your files. You
  can configure you editor to set this.
  * Vim: `autocmd BufWritePre * %s/\s\+$//e` to your `.vimrc`
  * Sublime: (This)[http://nategood.com/sublime-text-strip-whitespace-save]
  * Notepad++: `Alt+Shift+S`

## Dependencies and Installation

You'll need to use either the [Crazyflie VM](https://wiki.bitcraze.io/projects:virtualmachine:index),
[the toolbelt](https://wiki.bitcraze.io/projects:dockerbuilderimage:index) or
install some ARM toolchain.

Click
[here](https://github.com/HovakimyanResearch/cf-firmware/wiki/Installation)
to find out how to install the toolchains.

## Compiling for each vehicle

### Crazyflie

This is the dafault build so just running "make" is enough or:
```bash
make VEH=cf
```
### Q2

Build with:
```bash
make VEH=q2
```
### Bitcrze original

Build with:
```bash
make VEH=bitcraze
```

### Vehicle Configuration
To create custom build for a vehcile you need to create a folder with the name
of the vehile (eg: `q2_manip`) in the `configs` folder. You will need to
include the following files in this folder:
* `config.mk` : Vehicle specific flags
* `vehicle_params.h` : Controller params

These flags get imported as macros during complilation based on the vehicle
selected.

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
