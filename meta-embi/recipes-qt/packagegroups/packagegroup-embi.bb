DESCRIPTION = "Base packagegroup for Embi-OS Linux image"
SUMMARY = "Packagegroups which provide basic Embi-OS releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-embi-fonts \
    packagegroup-embi-base \
    packagegroup-embi-canbus \
    packagegroup-embi-samba \
    packagegroup-embi-alsa \
"

RDEPENDS:packagegroup-embi = "\
    packagegroup-embi-fonts \
    packagegroup-embi-base \
    packagegroup-embi-canbus \
    packagegroup-embi-samba \
    packagegroup-embi-alsa \
"

SUMMARY:packagegroup-embi-fonts = "Recommended fonts for any image"
RRECOMMENDS:packagegroup-embi-fonts = "\
    fontconfig-utils \
    ttf-dejavu-common \
    ttf-dejavu-sans \
    ttf-dejavu-sans-mono \
    ttf-ubuntu-mono \
    ttf-ubuntu-sans \
"

SUMMARY:packagegroup-embi-base = "Recommended for any image"
RRECOMMENDS:packagegroup-embi-base = "\
    glib-2.0 \
    udev-extraconf \
    udev \
"

SUMMARY:packagegroup-embi-canbus = "Recommended for using CAN Bus"
RRECOMMENDS:packagegroup-embi-canbus = "\
    libsocketcan \
    canutils \
"

SUMMARY:packagegroup-embi-samba = "Recommended for using Samba"
RRECOMMENDS:packagegroup-embi-samba = "\
    openldap \
    openldap-bin \
    samba \
    smbclient \
    cifs-utils \
"

SUMMARY:packagegroup-embi-alsa = "Recommended for using Alsa"
RRECOMMENDS:packagegroup-embi-alsa = "\
    alsa-utils \
    alsa-plugins \
    alsa-utils-aplay \
    alsa-utils-amixer \
"
