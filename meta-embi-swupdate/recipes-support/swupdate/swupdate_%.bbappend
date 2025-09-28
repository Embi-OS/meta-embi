FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

EMBI_SWUPDATE_HW_REVISION ?= "1.0"

SRC_URI += "\
    file://0001-Log-save_state.patch \
    file://background.jpg \
    file://10-swupdate-args \
    file://swupdate.cfg \
"

do_install:append () {
    install -m 644 ${WORKDIR}/background.jpg ${D}/www/images/
	
    install -d ${D}${sysconfdir}/swupdate/
    install -d ${D}${sysconfdir}/swupdate/conf.d/
    install -m 644 ${WORKDIR}/10-swupdate-args ${D}${libdir}/swupdate/conf.d/
    rm -f ${D}${libdir}/swupdate/conf.d/10-mongoose-args

    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${libdir}/swupdate/
    sed -i \
        -e 's/@MACHINE@/${MACHINE}/g' \
        -e 's/@EMBI_VERSION@/${EMBI_VERSION}/g' \
        -e 's/@QT_VERSION@/${QT_VERSION}/g' \
        ${D}${libdir}/swupdate/swupdate.cfg

    echo "${MACHINE} ${EMBI_SWUPDATE_HW_REVISION}" > ${WORKDIR}/hwrevision
    install -m 644 ${WORKDIR}/hwrevision ${D}${sysconfdir}
}
