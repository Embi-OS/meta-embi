############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://daemon.conf \
    "
    
do_install:append() {
    if [ -e "${WORKDIR}/daemon.conf" ]; then
        install -m 0644 ${WORKDIR}/daemon.conf ${D}${sysconfdir}/pulse/daemon.conf
    fi
}

