SUMMARY = "Packagegroups which provide cmdline releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-rpi-cli \
    packagegroup-rpi-utils \
"

RDEPENDS:packagegroup-rpi = "\
    packagegroup-rpi-cli \
    packagegroup-rpi-utils \
"

SUMMARY:packagegroup-rpi-cli = "Recommended for any image"
RRECOMMENDS:packagegroup-rpi-cli = "\
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

SUMMARY:packagegroup-rpi-utils = "Recommended for any image"
RRECOMMENDS:packagegroup-rpi-utils = "\
    u-boot \
    raspi-utils \
    boot-mount \
"

