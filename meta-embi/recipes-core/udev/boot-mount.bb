############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Systemd mount unit for Raspberry Pi boot partition"
DESCRIPTION = "Ensures the FAT boot partition is mounted at /boot early in boot"
LICENSE = "CLOSED"

SRC_URI = "\
    file://boot.mount \
"

inherit systemd

do_install () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/boot.mount ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "boot.mount"
