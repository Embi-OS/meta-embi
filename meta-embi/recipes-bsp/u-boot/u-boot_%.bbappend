FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:rpi = " \
    file://autoboot.cfg \
    file://env-fat-${BOOT_MEDIA}.cfg \
"
