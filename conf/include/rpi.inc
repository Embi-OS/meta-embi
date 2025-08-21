############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

DISABLE_OVERSCAN = "1"
DISABLE_SPLASH = "1"
#DISABLE_RPI_BOOT_LOGO = "1"

# add usb boot support
CMDLINE_ROOT_PARTITION = "/dev/sda2"
BOOT_MEDIA = "usb"

# add pci boot support
#CMDLINE_ROOT_PARTITION = "/dev/nvme0n1p2"
#BOOT_MEDIA = "pci"

# add wm8960 support
#MACHINE_FEATURES:append = " wm8960"

# rpi config
ENABLE_DWC2_PERIPHERAL = "0"
ENABLE_DWC2_HOST = "1"
ENABLE_I2C = "1"
ENABLE_SPI = "1"
ENABLE_UART = "1"
KERNEL_MODULE_AUTOLOAD:rpi += " i2c-dev i2c-bcm2708"

RPI_EXTRA_CONFIG:append = "# \
Enable Touch Display 2 \n\
dtoverlay=vc4-kms-dsi-ili9881-7inch,rotation=270 \n\n\
"

RPI_EXTRA_CONFIG:append = "# \
Enable Audio Amp SHIM \n\
dtoverlay=hifiberry-dac \n\
gpio=25=op,dh \n\n\
"

