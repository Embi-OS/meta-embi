FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEFAULT_LOCALE ?= "fr_CH"

do_install:append() {
    sed -i '/LANG=/ c\LANG=${DEFAULT_LOCALE}' ${D}${sysconfdir}/locale.conf
}
