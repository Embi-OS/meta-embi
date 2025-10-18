DESCRIPTION = "SWUpdate packagegroup"
SUMMARY = "Packagegroups which provide SWUpdate releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-swupdate-cli \
    packagegroup-swupdate-utils \
"

RDEPENDS:packagegroup-swupdate = "\
    packagegroup-swupdate-cli \
    packagegroup-swupdate-utils \
"

SUMMARY:packagegroup-swupdate-cli = "Recommended for using swupdate"
RRECOMMENDS:packagegroup-swupdate-cli = "\
    ostree \
    swupdate \
    swupdate-www \
    swupdate-client \
    swupdate-ipc \
    swupdate-progress \
"

SUMMARY:packagegroup-swupdate-utils = "Recommended utils for using swupdate"
RRECOMMENDS:packagegroup-swupdate-utils = "\
    overlayfs-persistent \
    fstab-mountpoints \
"
