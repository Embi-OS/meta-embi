############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Embi OS Image"
#SUMMARY:append = "${@' (Static Qt)' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''}"
 
IMAGE_INSTALL += " \
    packagegroup-rpi \
    packagegroup-embi \
"
