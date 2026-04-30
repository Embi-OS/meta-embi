############################################################################
##
## Config file related to the board
##
############################################################################

# For meta-raspberrypi
BOOT_MEDIA = "${PRODUCT_IMAGE_BRANCH}"
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

ENABLE_DEFAULT_CONFIG = "1"
DEFAULT_CONFIG_VERSION = "1"