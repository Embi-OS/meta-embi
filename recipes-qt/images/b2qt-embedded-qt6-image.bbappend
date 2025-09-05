############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Embi OS Image"
 
IMAGE_INSTALL += " \
    packagegroup-rpi \
    packagegroup-embi \
    ${@'embi-launcher' if bb.utils.to_boolean(d.getVar('USE_EMBI_LAUNCHER')) else ''} \
"
