FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEFAULT_LOCALE ?= "fr_CH"

SRC_URI += "\
    file://b2qt.sh \
"

RDEPENDS:${PN} += "bash"

do_install:append() {
    sed -i '/LANG=/ c\LANG=${DEFAULT_LOCALE}' ${D}${sysconfdir}/locale.conf

    install -d ${D}${bindir}/
    install -m 0755 ${WORKDIR}/b2qt.sh ${D}${bindir}
}
