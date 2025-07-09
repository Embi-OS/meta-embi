############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

#─── helper vars ───────────────────────────────────────────────────────────

# 1) The fixed bits
BOOT2QT_BASE   = "Boot2Qt ${PV}"
EMBI_OS_BASE   = "Embi-OS"

# 2) Reusable suffixes/prefixes based on static or not
EMBI_NAME_SUFFIX     = "${@ ' (Static)' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else '' }"
EMBI_INSTCOMP_PREFIX = "${@ 'static.'   if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else '' }"
EMBI_PATH_SUFFIX     = "${@ '_static'   if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else '' }"

#─── actual settings ─────────────────────────────────────────────────

QBSP_NAME                = "${BOOT2QT_BASE}${EMBI_NAME_SUFFIX}"
QBSP_OUTPUTNAME          = "meta-embios-embedded-qbsp-${SDKMACHINE}-${MACHINE}-${PV}"
QBSP_INSTALLER_COMPONENT = "embedded.b2qt.${EMBI_INSTCOMP_PREFIX}${VERSION_SHORT}.embios.${QBSP_MACHINE}"
QBSP_INSTALL_PATH        = "/${PV}/EmbiOS/${MACHINE}${EMBI_PATH_SUFFIX}"
DEPLOY_CONF_NAME:prepend = "${EMBI_OS_BASE} - "
