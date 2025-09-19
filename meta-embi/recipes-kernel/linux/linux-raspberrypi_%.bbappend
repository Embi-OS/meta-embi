############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://smb.cfg \
    file://tty.cfg \
    file://overlayfs.cfg \
    "
