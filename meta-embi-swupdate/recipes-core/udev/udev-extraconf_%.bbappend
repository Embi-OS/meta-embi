do_install:append() {
    echo "${EMBI_BOOT_PART}" >> ${D}${sysconfdir}/udev/mount.ignorelist
    echo "${EMBI_ROOTFS_PART_A}" >> ${D}${sysconfdir}/udev/mount.ignorelist
    echo "${EMBI_ROOTFS_PART_B}" >> ${D}${sysconfdir}/udev/mount.ignorelist
    echo "${EMBI_CONFIG_PART}" >> ${D}${sysconfdir}/udev/mount.ignorelist
}
