DESCRIPTION = "Meta task for Embi-OS QBSP creation"

#─── helper vars ───────────────────────────────────────────────────────────

BOOT2QT_BASE   = "Boot2Qt ${PV}"
EMBI_OS_BASE   = "Embi"

#─── actual settings ─────────────────────────────────────────────────

QBSP_IMAGE_TASK          = "embi-image"
QBSP_NAME                = "${BOOT2QT_BASE}"
QBSP_OUTPUTNAME          = "meta-embi-embedded-qbsp-${SDKMACHINE}-${MACHINE}-${PV}"
QBSP_INSTALLER_COMPONENT = "embedded.embi.${VERSION_SHORT}.${QBSP_MACHINE}"
QBSP_INSTALL_PATH        = "/${PV}/EmbiOS/${MACHINE}"
DEPLOY_CONF_NAME:prepend = "${EMBI_OS_BASE} - "
