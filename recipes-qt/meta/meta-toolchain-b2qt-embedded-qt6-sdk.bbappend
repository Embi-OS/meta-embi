############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

DESCRIPTION = "SDK toolchain for the Embi OS image"
DESCRIPTION:append = "${@' Static' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"

TOOLCHAIN_TARGET_TASK += " \
    packagegroup-rpi \
    packagegroup-embi \
"
