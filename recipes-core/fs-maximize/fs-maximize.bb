############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Add a script to expand the rootfs partion to the full size of its support"
DESCRIPTION = "Script to expand the rootfs partion to the full size of its support"
LICENSE = "CLOSED"

RRECOMMENDS:${PN} = "e2fsprogs-resize2fs"

MAXIMIZED_PARTITION ?= ""

SRC_URI = " \
    file://fs-maximize.sh \
"

do_install () {
    if [ "${MAXIMIZED_PARTITION}" != "" ]; then
        install -d ${D}/${sbindir}
        install -m 0755 ${WORKDIR}/fs-maximize.sh ${D}/${sbindir}
        sed -i 's#@ROOTFS_DISK@#${RPI_DISK_PARTITION}#' ${D}${sbindir}/fs-maximize.sh
        sed -i 's#@ROOTFS_PART@#${MAXIMIZED_PARTITION}#' ${D}${sbindir}/fs-maximize.sh
    fi
}

