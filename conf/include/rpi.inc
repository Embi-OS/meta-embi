############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

# Select boot medium: "mmc", "usb", "pci"
RPI_BOOT_MEDIA ?= "usb"

# For mmc and pci, one must use "p1", "p2" etc...
RPI_BOOTFS_NUM ?= "1"
RPI_ROOTFS_NUM ?= "2"

# Root partition mapping depending on boot media
RPI_DISK_PARTITION:mmc = "/dev/mmcblk0"
RPI_DISK_PARTITION:usb = "/dev/sda"
RPI_DISK_PARTITION:pci = "/dev/nvme0n1"
RPI_DISK_PARTITION = "${@d.getVar('RPI_DISK_PARTITION:' + d.getVar('RPI_BOOT_MEDIA'))}"
RPI_BOOT_PARTITION = "${RPI_DISK_PARTITION}${RPI_BOOTFS_NUM}"
RPI_ROOT_PARTITION = "${RPI_DISK_PARTITION}${RPI_ROOTFS_NUM}"

# For meta-raspberrypi, keep a BOOT_MEDIA var that mirrors RPI_BOOT_MEDIA
CMDLINE_ROOT_PARTITION = "${RPI_ROOT_PARTITION}"
BOOT_MEDIA = "${RPI_BOOT_MEDIA}"
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

