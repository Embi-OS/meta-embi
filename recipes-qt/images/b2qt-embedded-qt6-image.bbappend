############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

SUMMARY = "Embi OS Image"

IMAGE_LINGUAS += " \
    fr-fr \
    fr-ch \
    de-ch \
    it-ch \
    it-it \
    de-de \
    en-us \
    en-gb \
"
   
IMAGE_INSTALL += " \
    packagegroup-rpi \
    packagegroup-embi \
"
