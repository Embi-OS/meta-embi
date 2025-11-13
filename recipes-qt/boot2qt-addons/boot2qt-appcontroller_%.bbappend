FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://0001-Set-B2QT_PREFIX-to-etc-default-b2qt.patch \
    file://0002-Forward-QProcess-retVal-to-main.patch \
"
