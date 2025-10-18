DESCRIPTION = "Utils packagegroup"
SUMMARY = "Packagegroups which provide cli releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-utils-cli \
    packagegroup-utils-board \
"

RDEPENDS:packagegroup-utils = "\
    packagegroup-utils-cli \
    packagegroup-utils-board \
"

SUMMARY:packagegroup-utils-cli = "Recommended cli utils for any image"
RRECOMMENDS:packagegroup-utils-cli = "\
    can-utils \
    can-utils-cantest \
    dosfstools \
    e2fsprogs-mke2fs \
    iproute2 \
    libgomp \
    libgpiod \
    libgpiod-dev \
    libgpiod-tools \
    mtd-utils \
    u-boot-fw-utils \
    uhubctl \
    util-linux-fstrim \
    util-linux \
    nano \
    curl \
"

SUMMARY:packagegroup-utils-board = "Recommended boards utils for any image"
RRECOMMENDS:packagegroup-utils-board = "\
    u-boot \
    raspi-utils \
    boot-mount \
"

