############################################################################
##
## Config file related to raspberrypi
##
############################################################################

# For meta-raspberrypi
BOOT_MEDIA = "usb"
CMDLINE_ROOT_PARTITION = ""
WIC_CREATE_EXTRA_ARGS ?= "--no-fstab-update"

# enable u-boot support
RPI_USE_U_BOOT = "1"

# --------------------------------------------------------------------------
# General Raspberry Pi system config
# --------------------------------------------------------------------------
DISABLE_OVERSCAN = "1"
DISABLE_SPLASH = "1"
DISABLE_RPI_BOOT_LOGO = "1"

# Peripheral config
ENABLE_DWC2_PERIPHERAL = "1"
ENABLE_DWC2_HOST = "0"
ENABLE_I2C = "1"
ENABLE_SPI = "1"
ENABLE_UART = "1"

KERNEL_MODULE_AUTOLOAD:rpi += " i2c-dev i2c-bcm2708"

ENABLE_TOUCH_DISPLAY_2_7_INCH = "0"
ENABLE_WAVESHARE_7_INCH_C_DISPLAY = "1"
ENABLE_AUDIO_AMP_SHIM = "0"
ENABLE_IQAUDIO_DAC = "1"

