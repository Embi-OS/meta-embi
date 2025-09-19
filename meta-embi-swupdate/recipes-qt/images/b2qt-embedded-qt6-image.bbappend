IMAGE_INSTALL += " \
    ${@'packagegroup-swupdate' if bb.utils.to_boolean(d.getVar('EMBI_USE_SWUPDATE')) else ''} \
"

