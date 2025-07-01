############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

DESCRIPTION = "Embi OS Launcher"
LICENSE = "CLOSED"

inherit qt6-cmake systemd

SRC_URI += " \
    git://github.com/Embi-OS/embi-launcher.git;protocol=https;branch=main \
    file://embi-launcher.service \
    "

SRCREV = "${AUTOREV}"

DEPENDS += "qtbase qtdeclarative qtdeclarative-native qtvirtualkeyboard qtcharts qtsvg qtsvg-native"

S = "${WORKDIR}/git"

do_install:append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/embi-launcher.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE:${PN} = "embi-launcher.service"
