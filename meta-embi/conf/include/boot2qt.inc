############################################################################
##
## Config file related to boot2qt
##
############################################################################

# set embi version
EMBI_VERSION = "25.10.0"

# set machine hostname
MACHINE_HOSTNAME = "embi-${MACHINE}"

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

