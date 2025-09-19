LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit systemd

SRC_URI += " \
    file://sethostname \
    file://set-hostname.service \
"

FILES:${PN} = " \
    ${bindir} \
    ${systemd_system_unitdir} \
"

SYSTEMD_SERVICE:${PN} = " \
    set-hostname.service \
"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/sethostname ${D}${bindir}
    sed -i "s/@@MACHINE@@/${MACHINE}/g" ${D}${bindir}/sethostname
    sed -i "s/@@HOSTNAMECTL_OPT@@/${@bb.utils.contains('IMAGE_FEATURES','read-only-rootfs','--transient','',d)}/g" \
        ${D}${bindir}/sethostname
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/set-hostname.service ${D}${systemd_system_unitdir}
    fi
}
