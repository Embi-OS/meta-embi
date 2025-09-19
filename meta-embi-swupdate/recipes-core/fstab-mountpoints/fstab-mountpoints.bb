############################################################################
##
## This file is part of the meta-voh layer.
##
############################################################################

SUMMARY = "Ensure fstab mountpoints exist at boot"
DESCRIPTION = "Installs a script and systemd service that creates all mountpoints listed in /etc/fstab before local-fs.target."
LICENSE = "CLOSED"

SRC_URI = " \
    file://make-fstab-mountpoints.sh \
    file://fstab-mountpoints.service \
"

inherit systemd

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/make-fstab-mountpoints.sh ${D}${bindir}

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/fstab-mountpoints.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "fstab-mountpoints.service"

