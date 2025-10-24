############################################################################
##
## Config file related to swupdate
##
############################################################################

PRODUCT_BOOT_LABEL = "boot"
PRODUCT_ROOTFS_LABEL_A = "RFS1"
PRODUCT_ROOTFS_LABEL_B = "RFS2"
PRODUCT_CONFIG_LABEL = "config"

WKS_FILE = "embi-swupdate-sdimage-rpi.wks.in"
IMAGE_FSTYPES:append = " tar.zst"
IMAGE_FSTYPES:remove = "tar.bz2 ext3 wic.bz2 wic.bmap"

DISTRO_FEATURES:append = " overlayfs"
IMAGE_FEATURES:remove = "package-management"
EXTRA_IMAGE_FEATURES:append = " overlayfs-etc"
OVERLAYFS_ETC_MOUNT_POINT = "/config"
OVERLAYFS_ETC_DEVICE:mmc = "/dev/mmcblk0p4"
OVERLAYFS_ETC_DEVICE:usb = "/dev/sda4"
OVERLAYFS_ETC_DEVICE = "${@d.getVar('OVERLAYFS_ETC_DEVICE:' + d.getVar('BOOT_MEDIA'))}"
OVERLAYFS_ETC_FSTYPE ?= "ext4"
OVERLAYFS_ETC_USE_ORIG_INIT_NAME = "0"
APPEND:append = " init=/sbin/preinit"
CMDLINE_ROOTFS = ""
