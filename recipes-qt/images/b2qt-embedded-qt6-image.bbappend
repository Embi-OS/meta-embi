############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Embi OS Image"
 
IMAGE_INSTALL += " \
    packagegroup-rpi \
    packagegroup-embi \
    ${@'packagegroup-swupdate' if bb.utils.to_boolean(d.getVar('EMBI_USE_SWUPDATE')) else ''} \
    ${@'embi-launcher' if bb.utils.to_boolean(d.getVar('USE_EMBI_LAUNCHER')) else ''} \
"
