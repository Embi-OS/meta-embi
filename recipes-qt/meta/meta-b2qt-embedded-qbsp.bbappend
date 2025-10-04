DESCRIPTION = "Meta task for Embi-OS QBSP creation"

QBSP_IMAGE_TASK          = "${EMBI_IMAGE_BASENAME}"
IMAGE_BASENAME           = "${EMBI_IMAGE_BASENAME}-${BOOT_MEDIA}"
QBSP_NAME                = "Boot2Qt ${PV}"
QBSP_OUTPUTNAME          = "meta-embi-embedded-qbsp-${SDKMACHINE}-${MACHINE}-${PV}-${BOOT_MEDIA}"
QBSP_INSTALLER_COMPONENT = "embedded.embi.${VERSION_SHORT}.${QBSP_MACHINE}"
QBSP_INSTALL_PATH        = "/${PV}/EmbiOS/${MACHINE}"
DEPLOY_CONF_NAME:prepend = "Embi - "
