FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

EMBI_SWUPDATE_HW_REVISION ?= "1.0"

SYSTEMD_SRC_URI = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'file://systemd.cfg', '', d)}"

SRC_URI += "\
    file://80_reboot.conf \
    file://background.jpg \
    file://swupdate.cfg \
    ${SYSTEMD_SRC_URI} \
"

do_install:append () {
    install -m 644 ${WORKDIR}/background.jpg ${D}/www/images/
	
    install -d ${D}${sysconfdir}/swupdate/
    install -d ${D}${sysconfdir}/swupdate/conf.d/
    install -m 644 ${WORKDIR}/80_reboot.conf ${D}${sysconfdir}/swupdate/conf.d/

    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
    sed -e 's/@MACHINE@/${MACHINE}/' ${D}${sysconfdir}/swupdate.cfg

    echo "${MACHINE} ${EMBI_SWUPDATE_HW_REVISION}" > ${WORKDIR}/hwrevision
    install -m 644 ${WORKDIR}/hwrevision ${D}${sysconfdir}
}
