FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DESCRIPTION = "swu image for ${PRODUCT_COMPANY_NAME} Boot2Qt"
LICENSE = "CLOSED"

inherit swupdate

SRC_URI = " \
    file://sw-description \
    file://update.sh \
"

IMAGE_BASENAME = "${PRODUCT_IMAGE_NAME}"
IMAGE_NAME_SUFFIX = ""
IMAGE_VERSION_SUFFIX = ".${PRODUCT_VERSION_SHORT}"

# images to build before building swupdate image
IMAGE_DEPENDS = "b2qt-image"

META_SWUPDATE_TARGET_IMAGE = "${IMAGE_BASENAME}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
META_SWUPDATE_TARGET_IMAGE_FILE = "${META_SWUPDATE_TARGET_IMAGE}.tar.zst"
META_SWUPDATE_TARGET_IMAGE_BOOT_FILE = "${META_SWUPDATE_TARGET_IMAGE}.boot.tar.zst"

# images and files that will be included in the .swu image
SWUPDATE_IMAGES = " \
    ${META_SWUPDATE_TARGET_IMAGE_FILE} \
    ${META_SWUPDATE_TARGET_IMAGE_BOOT_FILE} \
    "

do_swupdate[cleandirs] += "${B}"
