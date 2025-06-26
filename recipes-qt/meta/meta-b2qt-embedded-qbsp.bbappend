############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

QBSP_NAME = "Embi OS ${PV}"
QBSP_INSTALLER_COMPONENT = "embedded.b2qt.${VERSION_SHORT}.${QBSP_MACHINE}"

QBSP_NAME:append = "${@' Static' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"
QBSP_INSTALLER_COMPONENT:append = "${@'.static' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"

