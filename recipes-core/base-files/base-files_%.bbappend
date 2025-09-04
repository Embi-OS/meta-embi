FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_install:append() {
    sed -i 's#@BOOTFS_PART@#${RPI_BLOCK_PARTITION}${RPI_BOOTFS_NUM}#' ${D}${sysconfdir}/fstab
    sed -i 's#@PERSIST_PART@#${RPI_BLOCK_PARTITION}${RPI_PERSIST_NUM}#' ${D}${sysconfdir}/fstab
}
