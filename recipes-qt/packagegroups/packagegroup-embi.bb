############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

DESCRIPTION = "Base packagegroup for Embi OS Linux image"
SUMMARY = "Packagegroups which provide basic Embi OS releated packages"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    packagegroup-embi-base \
    packagegroup-embi-canbus \
    packagegroup-embi-samba \
    packagegroup-embi-alsa \
    packagegroup-embi-network \
"

RDEPENDS:packagegroup-embi = "\
    packagegroup-embi-base \
    packagegroup-embi-canbus \
    packagegroup-embi-samba \
    packagegroup-embi-alsa \
    packagegroup-embi-network \
"

SUMMARY:packagegroup-base-embi-base = "Recommended for any image"
RRECOMMENDS:packagegroup-base-embi-base = "\
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

SUMMARY:packagegroup-embi-network = "Recommended for using NetworkManager"
RRECOMMENDS:packagegroup-embi-network = "\
    networkmanager \
    networkmanager-nmcli \
    modemmanager \
"
