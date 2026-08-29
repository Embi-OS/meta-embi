FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://b2qt-recovery.service \
    file://kms.conf \
"

DEFAULT_LOCALE ?= "fr_CH"

do_install:append() {
    install -D -m 0644 ${WORKDIR}/kms.conf ${D}${sysconfdir}/kms.conf

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/b2qt-recovery.service ${D}${systemd_unitdir}/system/
    sed -i \
        -e 's|@PRODUCT_APP_SERVICE_USER@|${PRODUCT_APP_SERVICE_USER}|g' \
        -e 's|@PRODUCT_APP_SERVICE_GROUP@|${PRODUCT_APP_SERVICE_GROUP}|g' \
        ${D}${systemd_unitdir}/system/b2qt.service

    sed -i '/LANG=/ c\LANG=${DEFAULT_LOCALE}' ${D}${sysconfdir}/locale.conf
}

SYSTEMD_SERVICE:${PN} += " b2qt-recovery.service"
