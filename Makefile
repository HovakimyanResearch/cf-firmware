# CrazyFlie's Makefile
# Copyright (c) 2011,2012 Bitcraze AB
# This Makefile compiles all the objet file to ./bin/ and the resulting firmware
# image in ./cfX.elf and ./cfX.bin

# Put your personal build config in tools/make/config.mk and DO NOT COMMIT IT!
# Make a copy of tools/make/config.mk.example to get you started
CFLAGS += $(EXTRA_CFLAGS)

######### JTAG and environment configuration ##########
OPENOCD           ?= openocd
OPENOCD_INTERFACE ?= interface/stlink-v2.cfg
OPENOCD_CMDS      ?=
CROSS_COMPILE     ?= arm-none-eabi-
PYTHON2           ?= python2
DFU_UTIL          ?= dfu-util
CLOAD             ?= 1
DEBUG             ?= 0
CLOAD_SCRIPT      ?= cfloader
CLOAD_CMDS        ?=
PLATFORM          ?= CF2
VEH               ?= cf

######### Vehicle configuration ##########
include configs/$(VEH)/config.mk

######### Stabilizer configuration ##########
##### Sets the name of the stabilizer module to use.
ESTIMATOR          ?= complementary
CONTROLLER         ?= pid
POWER_DISTRIBUTION ?= stock


OPENOCD_TARGET    ?= target/stm32f4x_stlink.cfg
USE_FPU           ?= 1


# Now needed for SYSLINK
CFLAGS += -DUSE_RADIOLINK_CRTP     # Set CRTP link to radio
CFLAGS += -DENABLE_UART          # To enable the uart
REV               ?= D

#OpenOCD conf
RTOS_DEBUG        ?= 0

############### Location configuration ################
FREERTOS = src/lib/FreeRTOS
ifeq ($(USE_FPU), 1)
PORT = $(FREERTOS)/portable/GCC/ARM_CM4F
else
PORT = $(FREERTOS)/portable/GCC/ARM_CM3
endif

LINKER_DIR = tools/make/F405/linker
ST_OBJ_DIR  = tools/make/F405

STLIB = src/lib

################ Build configuration ##################
# St Lib
VPATH_CF2 += $(STLIB)/CMSIS/STM32F4xx/Source/
VPATH_CF2 += $(STLIB)/STM32_CPAL_Driver/src
VPATH_CF2 += $(STLIB)/STM32_USB_Device_Library/Core/src
VPATH_CF2 += $(STLIB)/STM32_USB_OTG_Driver/src
VPATH_CF2 += $(STLIB)/STM32_CPAL_Driver/devices/stm32f4xx
VPATH_CF2 += src/deck/api src/deck/core src/deck/drivers/src src/deck/drivers/src/test
CRT0_CF2 = startup_stm32f40xx.o system_stm32f4xx.o

# Should maybe be in separate file?
-include $(ST_OBJ_DIR)/st_obj.mk

# USB obj
ST_OBJ_CF2 += usb_core.o usb_dcd_int.o usb_dcd.o
# USB Device obj
ST_OBJ_CF2 += usbd_ioreq.o usbd_req.o usbd_core.o

# libdw dw1000 driver
VPATH_CF2 += vendor/libdw1000/src

# FreeRTOS
VPATH += $(PORT)
PORT_OBJ = port.o
VPATH +=  $(FREERTOS)/portable/MemMang
MEMMANG_OBJ = heap_4.o

VPATH += $(FREERTOS)
FREERTOS_OBJ = list.o tasks.o queue.o timers.o $(MEMMANG_OBJ)

# Crazyflie sources
VPATH += src/init src/hal/src src/modules/src src/utils/src src/drivers/src
VPATH_CF2 += src/platform/cf2

VPATH +=$(VPATH_CF2)


############### Source files configuration ################

# Init
PROJ_OBJ += main.o
PROJ_OBJ_CF2 += platform_cf2.o

# Drivers
PROJ_OBJ += exti.o nvic.o motors.o
PROJ_OBJ_CF2 += led_f405.o mpu6500.o i2cdev_f405.o ws2812_cf2.o lps25h.o i2c_drv.o
PROJ_OBJ_CF2 += ak8963.o eeprom.o maxsonar.o piezo.o
PROJ_OBJ_CF2 += uart_syslink.o swd.o uart1.o uart2.o watchdog.o
PROJ_OBJ_CF2 += cppm.o
# USB Files
PROJ_OBJ_CF2 += usb_bsp.o usblink.o usbd_desc.o usb.o

# Hal
PROJ_OBJ += crtp.o ledseq.o freeRTOSdebug.o buzzer.o
PROJ_OBJ_CF2 += sensors_cf2.o pm_f405.o syslink.o radiolink.o ow_syslink.o proximity.o usec_time.o

# libdw
PROJ_OBJ_CF2 += libdw1000.o libdw1000Spi.o

# Modules
PROJ_OBJ += system.o comm.o console.o pid.o crtpservice.o param.o mem.o
PROJ_OBJ += log.o worker.o trigger.o sitaw.o queuemonitor.o
PROJ_OBJ_CF2 += platformservice.o sound_cf2.o extrx.o

# Stabilizer modules
PROJ_OBJ += commander.o ext_position.o
PROJ_OBJ += attitude_pid_controller.o sensfusion6.o stabilizer.o
PROJ_OBJ += position_estimator_altitude.o position_controller_pid.o
PROJ_OBJ += estimator_$(ESTIMATOR).o controller_$(CONTROLLER).o
PROJ_OBJ += power_distribution_$(POWER_DISTRIBUTION).o


# Deck Core
PROJ_OBJ_CF2 += deck.o deck_info.o deck_drivers.o deck_test.o

# Deck API
PROJ_OBJ_CF2 += deck_constants.o
PROJ_OBJ_CF2 += deck_digital.o
PROJ_OBJ_CF2 += deck_analog.o
PROJ_OBJ_CF2 += deck_spi.o

# Decks
PROJ_OBJ_CF2 += bigquad.o
PROJ_OBJ_CF2 += rzr.o
PROJ_OBJ_CF2 += ledring12.o
PROJ_OBJ_CF2 += buzzdeck.o
PROJ_OBJ_CF2 += gtgps.o
PROJ_OBJ_CF2 += dwm1000.o
PROJ_OBJ_CF2 += cppmdeck.o
#Deck tests
PROJ_OBJ_CF2 += exptest.o
#PROJ_OBJ_CF2 += bigquadtest.o


# Utilities
PROJ_OBJ += filter.o cpuid.o cfassert.o  eprintf.o crc.o num.o debug.o
PROJ_OBJ += version.o FreeRTOS-openocd.o
PROJ_OBJ_CF2 += configblockeeprom.o

# Libs
PROJ_OBJ_CF2 += libarm_math.a

OBJ = $(FREERTOS_OBJ) $(PORT_OBJ) $(ST_OBJ) $(PROJ_OBJ)
OBJ += $(CRT0_CF2) $(ST_OBJ_CF2) $(PROJ_OBJ_CF2)

ifdef P
  C_PROFILE = -D P_$(P)
endif

############### Compilation configuration ################
AS = $(CROSS_COMPILE)as
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)gcc
SIZE = $(CROSS_COMPILE)size
OBJCOPY = $(CROSS_COMPILE)objcopy
GDB = $(CROSS_COMPILE)gdb

INCLUDES  = -I$(FREERTOS)/include -I$(PORT) -Isrc
INCLUDES += -Isrc/config -Isrc/hal/interface -Isrc/modules/interface
INCLUDES += -Isrc/utils/interface -Isrc/drivers/interface -Isrc/platform
INCLUDES += -Ivendor/CMSIS/CMSIS/Include

INCLUDES_CF2 += -I$(STLIB)/STM32F4xx_StdPeriph_Driver/inc
INCLUDES_CF2 += -I$(STLIB)/CMSIS/STM32F4xx/Include
INCLUDES_CF2 += -I$(STLIB)/STM32_CPAL_Driver/inc
INCLUDES_CF2 += -I$(STLIB)/STM32_CPAL_Driver/devices/stm32f4xx
INCLUDES_CF2 += -I$(STLIB)/STM32_USB_Device_Library/Core/inc
INCLUDES_CF2 += -I$(STLIB)/STM32_USB_OTG_Driver/inc
INCLUDES_CF2 += -Isrc/deck/interface -Isrc/deck/drivers/interface
INCLUDES_CF2 += -Ivendor/libdw1000/inc

INCLUDES += -Iconfigs/$(VEH)

ifeq ($(USE_FPU), 1)
	PROCESSOR = -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
	CFLAGS += -fno-math-errno -DARM_MATH_CM4 -D__FPU_PRESENT=1 -D__TARGET_FPU_VFP
else
	PROCESSOR = -mcpu=cortex-m4 -mthumb
endif

#Flags required by the ST library
STFLAGS_CF2 = -DSTM32F4XX -DSTM32F40_41xxx -DHSE_VALUE=8000000 -DUSE_STDPERIPH_DRIVER -DPLATFORM_CF2

ifeq ($(DEBUG), 1)
  CFLAGS += -O0 -g3 -DDEBUG
else
  CFLAGS += -Os -g3
endif

ifeq ($(LTO), 1)
  CFLAGS += -flto
endif

ifeq ($(USE_ESKYLINK), 1)
  CFLAGS += -DUSE_ESKYLINK
endif

CFLAGS += -DBOARD_REV_$(REV) -DESTIMATOR_TYPE_$(ESTIMATOR) -DCONTROLLER_TYPE_$(CONTROLLER) -DPOWER_DISTRIBUTION_TYPE_$(POWER_DISTRIBUTION)

CFLAGS += $(PROCESSOR) $(INCLUDES) $(STFLAGS)
CFLAGS += $(INCLUDES_CF2) $(STFLAGS_CF2)
CFLAGS += $(VEH_FLAGS)

CFLAGS += -Wall -Wmissing-braces -fno-strict-aliasing $(C_PROFILE) -std=gnu11
# Compiler flags to generate dependency files:
CFLAGS += -MD -MP -MF $(BIN)/dep/$(@).d -MQ $(@)
#Permits to remove un-used functions and global variables from output file
CFLAGS += -ffunction-sections -fdata-sections

# Fail on warnings
CFLAGS += -Werror

ASFLAGS = $(PROCESSOR) $(INCLUDES)
LDFLAGS = --specs=nano.specs $(PROCESSOR) -Wl,-Map=$(PROG).map,--cref,--gc-sections,--undefined=uxTopUsedPriority

#Flags required by the ST library
ifeq ($(CLOAD), 1)
  LDFLAGS += -T $(LINKER_DIR)/FLASH_CLOAD.ld
  LOAD_ADDRESS = 0x8004000
else
  LDFLAGS += -T $(LINKER_DIR)/FLASH.ld
  LOAD_ADDRESS = 0x8000000
endif

ifeq ($(LTO), 1)
  LDFLAGS += -Os -flto -fuse-linker-plugin
endif

#Program name
PROG = $(VEH)

#Where to compile the .o
BIN = bin
VPATH += $(BIN)

#Dependency files to include
DEPS := $(foreach o,$(OBJ),$(BIN)/dep/$(o).d)

##################### Misc. ################################
ifeq ($(SHELL),/bin/sh)
  COL_RED=\033[1;31m
  COL_GREEN=\033[1;32m
  COL_RESET=\033[m
endif

#################### Targets ###############################


all: check_submodules build
build: clean_version compile print_version size
compile: clean_version $(PROG).hex $(PROG).bin $(PROG).dfu

libarm_math.a:
	+$(MAKE) -C tools/make/cmsis_dsp/ V=$(V)

clean_version:
ifeq ($(SHELL),/bin/sh)
	@echo "  CLEAN_VERSION"
	@rm -f version.c
endif

print_version: compile
	@echo "$(VEH) build!"
	@$(PYTHON2) tools/make/versionTemplate.py --print-version
ifeq ($(CLOAD), 1)
	@echo "Crazyloader build!"
endif


size: compile
	@$(SIZE) -B $(PROG).elf

#Radio bootloader
cload:
ifeq ($(CLOAD), 1)
	$(CLOAD_SCRIPT) $(CLOAD_CMDS) flash $(PROG).bin stm32-fw
else
	@echo "Only cload build can be bootloaded. Launch build and cload with CLOAD=1"
endif

#Flash the stm.
flash:
	$(OPENOCD) -d2 -f $(OPENOCD_INTERFACE) $(OPENOCD_CMDS) -f $(OPENOCD_TARGET) -c init -c targets -c "reset halt" \
                 -c "flash write_image erase $(PROG).elf" -c "verify_image $(PROG).elf" -c "reset run" -c shutdown

flash_dfu:
	$(DFU_UTIL) -a 0 -D $(PROG).dfu

#STM utility targets
halt:
	$(OPENOCD) -d0 -f $(OPENOCD_INTERFACE) $(OPENOCD_CMDS) -f $(OPENOCD_TARGET) -c init -c targets -c "halt" -c shutdown

reset:
	$(OPENOCD) -d0 -f $(OPENOCD_INTERFACE) $(OPENOCD_CMDS) -f $(OPENOCD_TARGET) -c init -c targets -c "reset" -c shutdown

openocd:
	$(OPENOCD) -d2 -f $(OPENOCD_INTERFACE) $(OPENOCD_CMDS) -f $(OPENOCD_TARGET) -c init -c targets -c "\$$_TARGETNAME configure -rtos auto"

trace:
	$(OPENOCD) -d2 -f $(OPENOCD_INTERFACE) $(OPENOCD_CMDS) -f $(OPENOCD_TARGET) -c init -c targets -f tools/trace/enable_trace.cfg

gdb: $(PROG).elf
	$(GDB) -ex "target remote localhost:3333" -ex "monitor reset halt" $^

erase:
	$(OPENOCD) -d2 -f $(OPENOCD_INTERFACE) -f $(OPENOCD_TARGET) -c init -c targets -c "halt" -c "stm32f4x mass_erase 0" -c shutdown

#Print preprocessor #defines
prep:
	@$(CC) $(CFLAGS) -dM -E - < /dev/null

check_submodules:
	@$(PYTHON2) tools/make/check-for-submodules.py

include tools/make/targets.mk

#include dependencies
-include $(DEPS)
