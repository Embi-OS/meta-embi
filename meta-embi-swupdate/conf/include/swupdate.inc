############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

# add swupdate support
EMBI_USE_SWUPDATE ?= "1"

# sd-card partition
WKS_FILE = "embi-swupdate-sdimage-rpi.wks"

EMBI_BOOTFS_PART_A = "/dev/mmcblk0p1"
EMBI_ROOTFS_PART_A = "/dev/mmcblk0p2"
EMBI_ROOTFS_PART_B = "/dev/mmcblk0p3"
EMBI_CONFIG_PART = "/dev/mmcblk0p4"

IMAGE_FSTYPES:append = " \
    ${@'tar.zst' if bb.utils.to_boolean(d.getVar('EMBI_USE_SWUPDATE')) else ''} \
"

# Only apply SWUpdate append recipes if EMBI_USE_SWUPDATE is set
BBMASK += "${@'' if bb.utils.to_boolean(d.getVar('EMBI_USE_SWUPDATE')) else '/meta-embi-swupdate/'}"

DISTRO_FEATURES:append = " overlayfs"
IMAGE_FEATURES:remove = "package-management"
EXTRA_IMAGE_FEATURES:append = " overlayfs-etc"
OVERLAYFS_ETC_MOUNT_POINT = "/config"
OVERLAYFS_ETC_DEVICE = "${EMBI_CONFIG_PART}"
OVERLAYFS_ETC_FSTYPE ?= "ext4"
OVERLAYFS_ETC_USE_ORIG_INIT_NAME = "0"
APPEND:append = " init=\/sbin\/preinit"
