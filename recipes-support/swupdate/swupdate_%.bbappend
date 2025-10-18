FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

META_SWUPDATE_HW_REVISION ?= "1.0"

SRC_URI += "\
    file://0001-Log-save_state.patch \
    file://background.jpg \
    file://favicon.png \
    file://logo.png \
    file://swupdate.ini \
    file://swupdate.cfg.in \
"

do_install:append () {
    install -m 644 ${WORKDIR}/background.jpg ${D}/www/images/
    install -m 644 ${WORKDIR}/favicon.png ${D}/www/images/
    install -m 644 ${WORKDIR}/logo.png ${D}/www/images/
	
    install -d ${D}${sysconfdir}/swupdate/
    install -d ${D}${sysconfdir}/swupdate/conf.d/
    rm -f ${D}${libdir}/swupdate/conf.d/10-mongoose-args

    install -m 644 ${WORKDIR}/swupdate.ini ${D}${sysconfdir}/swupdate/
    install -m 644 ${WORKDIR}/swupdate.cfg.in ${D}${libdir}/swupdate/
    sed -i \
        -e 's/@BB_MACHINE_NAME@/${MACHINE}/g' \
        -e 's/@BB_IMAGE_NAME@/${PRODUCT_IMAGE_BASENAME}/g' \
        -e 's/@BB_IMAGE_VERSION@/${PRODUCT_VERSION}/g' \
        ${D}${libdir}/swupdate/swupdate.cfg.in

    echo "${MACHINE} ${META_SWUPDATE_HW_REVISION}" > ${WORKDIR}/hwrevision
    install -m 644 ${WORKDIR}/hwrevision ${D}${sysconfdir}
    
    echo "${PRODUCT_VERSION}" > ${WORKDIR}/swversion
    install -m 644 ${WORKDIR}/swversion ${D}${sysconfdir}
}
