FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://b2qt-recovery.service \
"

DEFAULT_LOCALE ?= "fr_CH"

do_install:append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/b2qt-recovery.service ${D}${systemd_unitdir}/system/

    sed -i '/LANG=/ c\LANG=${DEFAULT_LOCALE}' ${D}${sysconfdir}/locale.conf
}

SYSTEMD_SERVICE:${PN} += " b2qt-recovery.service"
