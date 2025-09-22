FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:rpi = " \
    file://env-fat-${BOOT_MEDIA}.cfg \
"
