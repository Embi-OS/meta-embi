############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Packagegroups which provide cmdline releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-base-rpi-cli \
"

RDEPENDS:packagegroup-rpi = "\
    packagegroup-base-rpi-cli \
"

SUMMARY:packagegroup-base-rpi-cli = "Recommended for any image"
RRECOMMENDS:packagegroup-base-rpi-cli = "\
    can-utils \
    can-utils-cantest \
    dosfstools \
    e2fsprogs-mke2fs \
    iproute2 \
    libgomp \
    libgpiod \
    libgpiod-dev \
    libgpiod-tools \
    uhubctl \
    util-linux-fstrim \
    util-linux \
    nano \
    curl \
"


