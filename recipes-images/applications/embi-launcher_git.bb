DESCRIPTION = "Embi-OS Launcher"
LICENSE = "CLOSED"

inherit qt6-cmake systemd

SRC_URI += " \
    git://github.com/Embi-OS/embi-launcher.git;protocol=https;branch=main \
    file://embi-launcher.service \
    "

SRCREV = "${AUTOREV}"

# Build-time deps
DEPENDS += " \
    qtbase \
    qtdeclarative \
    qtdeclarative-native \
    qtvirtualkeyboard \
    qtcharts \
    qtsvg \
    qtsvg-native \
    swupdate \
"

S = "${WORKDIR}/git"

BUILD_TYPE ?= "Release"

EXTRA_OECMAKE += " \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DENABLE_OPTIMIZATION=ON \
"

do_install:append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/embi-launcher.service ${D}${systemd_unitdir}/system/
    sed -i \
        -e 's|@PRODUCT_APP_SERVICE_USER@|${PRODUCT_APP_SERVICE_USER}|g' \
        -e 's|@PRODUCT_APP_SERVICE_GROUP@|${PRODUCT_APP_SERVICE_GROUP}|g' \
        ${D}${systemd_unitdir}/system/embi-launcher.service
}

FILES:${PN} += " \
    /Embi/* \
    "
    
SYSTEMD_SERVICE:${PN} = "embi-launcher.service"
