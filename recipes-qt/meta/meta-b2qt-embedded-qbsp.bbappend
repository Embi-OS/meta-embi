############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

QBSP_NAME = "Embi OS ${PV}"
QBSP_NAME:append = "${@' (Static Qt)' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"

QBSP_INSTALLER_COMPONENT:append = "${@'.static' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"
QBSP_INSTALL_PATH:append = "${@'_static' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"
