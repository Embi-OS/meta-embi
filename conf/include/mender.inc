############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

MENDER_ARTIFACT_NAME = "release-1"
INHERIT += "mender-full"
 
INIT_MANAGER = "systemd"
 
INHERIT += "mender-toradex"
 
MENDER_FEATURES_ENABLE:append = " mender-uboot mender-image-sd"
MENDER_FEATURES_DISABLE:append = " mender-grub mender-image-uefi"

IMAGE_CLASSES += "image_type_mender_tezi"
IMAGE_FSTYPES:append = " mender_tezi"
IMAGE_FSTYPES:remove = " teziimg"
 
KERNEL_IMAGETYPE:aarch64_mender-grub = "Image"
IMAGE_BOOT_FILES:remove:mender-grub = "boot.scr-verdin-imx8mm;boot.scr"
 
IMAGE_BOOT_FILES:remove:mender-uboot = "zImage ${KERNEL_DEVICETREE} overlays.txt overlays/*;overlays/"

MENDER_IMAGE_BOOTLOADER_BOOTSECTOR_OFFSET:apalis-imx8 = "0"
MENDER_BOOT_PART_SIZE_MB:apalis-imx8 = "32"
OFFSET_SPL_PAYLOAD:apalis-imx8 = ""
MENDER_STORAGE_DEVICE:apalis-imx8 = "/dev/mmcblk0"
MENDER_STORAGE_TOTAL_SIZE_MB:apalis-imx8 = "12288" 
MENDER_UBOOT_POST_SETUP_COMMANDS:append = " ; setenv tdxargs ${tdxargs} ${bootargs}; "

MENDER_UBOOT_POST_SETUP_COMMANDS:append = " ; setenv overlays_file /boot/overlays.txt;setenv overlays_prefix boot/overlays/ "
