############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

# add usb boot support
#CMDLINE_ROOT_PARTITION = "/dev/sda2"
#BOOT_MEDIA = "usb"

# add pci boot support
#CMDLINE_ROOT_PARTITION = "/dev/nvme0n1p2"
#BOOT_MEDIA = "pci"

# rpi config
ENABLE_DWC2_PERIPHERAL = "0"
ENABLE_DWC2_HOST = "1"
ENABLE_I2C = "1"
ENABLE_SPI = "1"
ENABLE_UART = "1"
KERNEL_MODULE_AUTOLOAD:rpi += " i2c-dev i2c-bcm2708"

RPI_EXTRA_CONFIG:append = "# \
Enable waveshare 7_0_inchC display \n\
dtoverlay=vc4-kms-dsi-waveshare-panel,7_0_inchC,i2c1 \n\
"

