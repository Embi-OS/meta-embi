############################################################################
##
## Config file related to swupdate
##
############################################################################

EMBI_BOOT_LABEL = "boot"
EMBI_ROOTFS_LABEL_A = "RFS1"
EMBI_ROOTFS_LABEL_B = "RFS2"
EMBI_CONFIG_LABEL = "config"

WKS_FILE = "embi-swupdate-sdimage-rpi.wks.in"
IMAGE_FSTYPES:append = " \
    tar.zst \
"

DISTRO_FEATURES:append = " overlayfs"
IMAGE_FEATURES:remove = "package-management"
EXTRA_IMAGE_FEATURES:append = " overlayfs-etc"
OVERLAYFS_ETC_MOUNT_POINT = "/config"
OVERLAYFS_ETC_DEVICE = "/dev/sda4"
OVERLAYFS_ETC_FSTYPE ?= "ext4"
OVERLAYFS_ETC_USE_ORIG_INIT_NAME = "0"
APPEND:append = " init=/sbin/preinit"
CMDLINE_ROOTFS = ""
