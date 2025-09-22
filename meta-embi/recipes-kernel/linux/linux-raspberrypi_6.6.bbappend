############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

LINUX_VERSION = "6.6.78"

SRCREV_machine = "bba53a117a4a5c29da892962332ff1605990e17a"
SRCREV_meta = "8315cf9f3b698885f5c4693582d27d66c511f8c5"

SRC_URI += "\
    file://smb.cfg \
    file://tty.cfg \
    file://overlayfs.cfg \
    "
