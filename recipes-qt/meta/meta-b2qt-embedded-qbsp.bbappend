############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

#─── helper vars ───────────────────────────────────────────────────────────

# 1) The fixed bits
BOOT2QT_BASE       = "Boot2Qt ${PV}"
EMBI_OS_BASE       = "Embi OS ${PV}"
EMBI_QBSP_BASE     = "meta-embios-embedded-qbsp-${SDKMACHINE}-${MACHINE}-${PV}"

# 2) Reusable suffixes/prefixes based on static or not
EMBI_NAME_SUFFIX        = "${@ ' (Static Qt)'       if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else '' }"
EMBI_INSTCOMP_PREFIX    = "${@ 'static.'            if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else '' }"
EMBI_PATH_SUFFIX        = "${@ '_static'            if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else '' }"

#─── actual settings ─────────────────────────────────────────────────

QBSP_NAME               = "${EMBI_OS_BASE}${EMBI_NAME_SUFFIX}"
QBSP_OUTPUTNAME         = "${EMBI_QBSP_BASE}"
QBSP_INSTALLER_COMPONENT= "embedded.embios.${EMBI_INSTCOMP_PREFIX}${VERSION_SHORT}.${QBSP_MACHINE}"
QBSP_INSTALL_PATH       = "/${PV}/EmbiOS/${MACHINE}${EMBI_PATH_SUFFIX}"
DEPLOY_CONF_NAME:prepend= "${BOOT2QT_BASE}${EMBI_NAME_SUFFIX} - "
