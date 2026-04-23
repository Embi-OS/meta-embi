DESCRIPTION = "Meta task for QBSP creation"

QBSP_NAME                = "Boot2Qt ${QT_VERSION}"
QBSP_INSTALL_PATH        = "/${QT_VERSION}/Boot2Qt/${MACHINE}"

QBSP_SDK_TASK            = "meta-toolchain-b2qt-embedded-qt6-sdk"
QBSP_IMAGE_TASK          = "b2qt-image"

IMAGE_BASENAME           = "${PRODUCT_IMAGE_NAME}"
IMAGE_NAME_SUFFIX        = ""
IMAGE_VERSION_SUFFIX     = ".${PRODUCT_VERSION_SHORT}"
QBSP_OUTPUTNAME          = "meta-${PRODUCT_COMPANY_NAME_LOWER}-embedded-qbsp-${SDKMACHINE}-${MACHINE}-${PV}-${PRODUCT_IMAGE_BRANCH}"
QBSP_INSTALLER_COMPONENT = "embedded.${PRODUCT_COMPANY_NAME_LOWER}.${@d.getVar('QT_VERSION').replace('.','')}.${QBSP_MACHINE}"
DEPLOY_CONF_NAME:prepend = "${PRODUCT_COMPANY_NAME} - "
