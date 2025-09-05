FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append() {
    sed -i 's#@BOOTFS_PART@#${RPI_BOOT_PARTITION}#' ${D}${sysconfdir}/fstab
}
