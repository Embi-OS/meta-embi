############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

DESCRIPTION = "SWUpdate packagegroup for Embi OS Linux image"
SUMMARY = "Packagegroups which provide SWUpdate releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-swupdate-cli \
"

RDEPENDS:packagegroup-swupdate = "\
    packagegroup-swupdate-cli \
"

SUMMARY:packagegroup-swupdate-cli = "Recommended for using swupdate"
RRECOMMENDS:packagegroup-swupdate-cli = "\
    ostree \
    swupdate \
    swupdate-www \
    swupdate-client \
    swupdate-progress \
"

