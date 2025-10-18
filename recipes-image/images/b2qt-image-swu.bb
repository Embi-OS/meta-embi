FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DESCRIPTION = "swu image for ${PRODUCT_COMPANY_NAME} Boot2Qt"
LICENSE = "CLOSED"

SRC_URI = " \
    file://sw-description \
    file://update.sh \
"

inherit swupdate

IMAGE_BASENAME = "${PRODUCT_IMAGE_BASENAME}-${PRODUCT_IMAGE_BRANCH}"
IMAGE_NAME_SUFFIX = ""
IMAGE_VERSION_SUFFIX = ".${PRODUCT_VERSION_SHORT}"

META_SWUPDATE_TARGET_IMAGE = "b2qt-image"
META_SWUPDATE_TARGET_IMAGE_FSTYPE = ".tar.zst"

META_SWUPDATE_TARGET_IMAGE_FILE = "${IMAGE_BASENAME}-${MACHINE}${IMAGE_VERSION_SUFFIX}${META_SWUPDATE_TARGET_IMAGE_FSTYPE}"

# IMAGE_DEPENDS: list of Yocto images that contains a root filesystem
# it will be ensured they are built before creating swupdate image
IMAGE_DEPENDS = "${META_SWUPDATE_TARGET_IMAGE}"

# SWUPDATE_IMAGES: list of images that will be part of the compound image
# the list can have any binaries - images must be in the DEPLOY directory
SWUPDATE_IMAGES = " \
    ${META_SWUPDATE_TARGET_IMAGE_FILE} \
"

# Images can have multiple formats - define which image must be
# taken to be put in the compound image
# This anonymous python function is equivalent to:
# SWUPDATE_IMAGES_FSTYPES["${META_SWUPDATE_TARGET_IMAGE}"] = "${META_SWUPDATE_TARGET_IMAGE_FSTYPE}"
# however it must be a python function as Bitbake does not expand variables as flag names.
python() {
    d.setVarFlag("SWUPDATE_IMAGES_FSTYPES", "META_SWUPDATE_TARGET_IMAGE", d.getVar("META_SWUPDATE_TARGET_IMAGE_FSTYPE"))
}

# Ensure the QBSP package is built whenever we build the SWUpdate image
do_build[depends] += "meta-b2qt-embedded-qbsp:do_build"

do_swupdate[cleandirs] += "${B}"
