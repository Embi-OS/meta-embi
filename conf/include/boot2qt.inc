############################################################################
##
## Config file related to boot2qt
##
############################################################################

# set product version
PRODUCT_COMPANY_NAME = "Embi"
PRODUCT_COMPANY_NAME_LOWER = "embi"
PRODUCT_VERSION = "25.10.0"
PRODUCT_VERSION_SHORT = "${@''.join('%02d' % int(x) for x in (d.getVar('PRODUCT_VERSION') or '0.0.0').split('.'))}"
PRODUCT_IMAGE_BASENAME = "${PRODUCT_COMPANY_NAME_LOWER}-image"
PRODUCT_IMAGE_BRANCH ?= "mmc"

# set machine hostname
MACHINE_HOSTNAME = "${PRODUCT_COMPANY_NAME_LOWER}-${MACHINE}"

# default to commercial Qt "opensource"
QT_EDITION = "commercial"

# include commercial addons and enable Qt QML Compiler "0"
QT_COMMERCIAL_MODULES = "1"

# remove boot2qt-demolauncher
USE_QT_DEMO_LAUNCHER = "0"

# remove webengine for faster build time
DISTRO_FEATURES:remove = "webengine ld-is-gold"

# remove virtualization
DISTRO_FEATURES:remove = "virtualization"

# remove debug-tweaks for production build
IMAGE_FEATURES:remove = "debug-tweaks"
EXTRA_IMAGE_FEATURES:remove = "debug-tweaks"

# append locales
IMAGE_LINGUAS:append = " \
    fr-fr \
    fr-ch \
    it-ch \
    it-it \
    de-de \
    de-ch \
    en-us \
    en-gb \
"

