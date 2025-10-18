SUMMARY = "${PRODUCT_COMPANY_NAME} Boot2Qt Image [${PRODUCT_IMAGE_BRANCH}]"
LICENSE = "CLOSED"

DEPLOY_CONF_TYPE = "Boot2Qt ${QT_VERSION}"

IMAGE_FEATURES += "\
        package-management \
        ssh-server-openssh \
        tools-debug \
        tools-profile \
        debug-tweaks \
        hwcodecs \
        "

inherit core-image deploy-buildinfo
inherit consistent_timestamps

IMAGE_BASENAME = "${PRODUCT_IMAGE_BASENAME}-${PRODUCT_IMAGE_BRANCH}"
IMAGE_NAME_SUFFIX = ""
IMAGE_VERSION_SUFFIX = ".${PRODUCT_VERSION_SHORT}"

# add some extra space to the device images
IMAGE_ROOTFS_EXTRA_SPACE = "100000"

IMAGE_INSTALL += "\
    packagegroup-qt6-modules \
    packagegroup-b2qt-embedded-base \
    packagegroup-b2qt-embedded-tools \
    packagegroup-b2qt-embedded-addons \
    ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer", "packagegroup-b2qt-embedded-gstreamer", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "virtualization", "packagegroup-docker", "", d)} \
    packagegroup-utils \
    packagegroup-system \
    packagegroup-swupdate \
    embi-ecosystem \
"
