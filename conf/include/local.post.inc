############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

# default to commercial Qt "opensource"
QT_EDITION = "commercial"

# include commercial addons and enable Qt QML Compiler "0"
QT_COMMERCIAL_MODULES = "1"
MACHINE_FEATURES:append = " wm8960"

# remove webengine for faster build time
DISTRO_FEATURES:remove = "webengine ld-is-gold"

IMAGE_LINGUAS:append = " \
    fr-fr \
    fr-ch \
    de-ch \
    de-de \
    it-ch \
    it-it \
    en-us \
    en-gb \
"
  
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
