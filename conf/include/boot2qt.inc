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

# add wm8960 support
MACHINE_FEATURES:append = " wm8960"

# rpi config
ENABLE_DWC2_PERIPHERAL = "0"
ENABLE_DWC2_HOST = "1"
ENABLE_I2C = "1"
ENABLE_SPI = "1"
ENABLE_UART = "1"
KERNEL_MODULE_AUTOLOAD:rpi += " i2c-dev i2c-bcm2708"

RPI_EXTRA_CONFIG:append = "# \
Enable waveshare 7_0_inchC display \n\
dtoverlay=vc4-kms-dsi-waveshare-panel,7_0_inchC,i2c1 \n\
"
