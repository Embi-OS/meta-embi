############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

# sd-card partition
WKS_FILE = "embi-swupdate-sdimage-rpi.wks"

EMBI_BOOTFS_PART_A = "/dev/mmcblk0p1"
EMBI_ROOTFS_PART_A = "/dev/mmcblk0p2"
EMBI_ROOTFS_PART_B = "/dev/mmcblk0p3"
EMBI_CONFIG_PART = "/dev/mmcblk0p4"

IMAGE_FSTYPES:append = " \
    tar.zst \
"

DISTRO_FEATURES:append = " overlayfs"
IMAGE_FEATURES:remove = "package-management"
EXTRA_IMAGE_FEATURES:append = " overlayfs-etc"
OVERLAYFS_ETC_MOUNT_POINT = "/config"
OVERLAYFS_ETC_DEVICE = "${EMBI_CONFIG_PART}"
OVERLAYFS_ETC_FSTYPE ?= "ext4"
OVERLAYFS_ETC_USE_ORIG_INIT_NAME = "0"
APPEND:append = " init=\/sbin\/preinit"
