############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

# default to commercial Qt "opensource"
QT_EDITION = "commercial"

# include commercial addons and enable Qt QML Compiler "0"
QT_COMMERCIAL_MODULES = "1"

# remove boot2qt-demolauncher
USE_QT_DEMO_LAUNCHER = "0"

# remove webengine for faster build time
DISTRO_FEATURES:remove = "webengine ld-is-gold"

# remove wayland for lighter image
DISTRO_FEATURES:remove = "wayland vulkan"

# remove debug-tweaks for production build
#IMAGE_FEATURES:remove = "debug-tweaks"
#EXTRA_IMAGE_FEATURES:remove = "debug-tweaks"

# Qt build configuration
BB_ENV_PASSTHROUGH_ADDITIONS += "EMBI_QTBASE_OPTIMIZE_SIZE EMBI_QTBASE_STATIC EMBI_QTBASE_LTCG"

EMBI_QTBASE_OPTIMIZE_SIZE ?= "0"
EMBI_QTBASE_STATIC ?= "0"
EMBI_QTBASE_LTCG ?= "0"

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

