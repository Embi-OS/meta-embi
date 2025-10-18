DESCRIPTION = "System packagegroup"
SUMMARY = "Packagegroups which provide system releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-system-base \
    packagegroup-system-fonts \
    packagegroup-system-canbus \
    packagegroup-system-samba \
    packagegroup-system-alsa \
"

RDEPENDS:packagegroup-system = "\
    packagegroup-system-base \
    packagegroup-system-fonts \
    packagegroup-system-canbus \
    packagegroup-system-samba \
    packagegroup-system-alsa \
"

SUMMARY:packagegroup-system-base = "Recommended for any image"
RRECOMMENDS:packagegroup-system-base = "\
    glib-2.0 \
    udev-extraconf \
    udev \
    fstab-mountpoints \
"

SUMMARY:packagegroup-system-fonts = "Recommended fonts for any image"
RRECOMMENDS:packagegroup-system-fonts = "\
    fontconfig-utils \
    ttf-dejavu-common \
    ttf-dejavu-sans \
    ttf-dejavu-sans-mono \
    ttf-ubuntu-mono \
    ttf-ubuntu-sans \
"

SUMMARY:packagegroup-system-canbus = "Recommended for using CAN Bus"
RRECOMMENDS:packagegroup-system-canbus = "\
    libsocketcan \
    canutils \
"

SUMMARY:packagegroup-system-samba = "Recommended for using Samba"
RRECOMMENDS:packagegroup-system-samba = "\
    openldap \
    openldap-bin \
    samba \
    smbclient \
    cifs-utils \
"

SUMMARY:packagegroup-system-alsa = "Recommended for using Alsa"
RRECOMMENDS:packagegroup-system-alsa = "\
    alsa-utils \
    alsa-plugins \
    alsa-utils-aplay \
    alsa-utils-amixer \
"

