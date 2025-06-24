############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

PACKAGECONFIG += "\
    sql-mysql \
    "
    
PACKAGECONFIG:append = "${@' ltcg' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_LTCG', True)) else ''}"
PACKAGECONFIG:append = "${@' optimize-size' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_OPTIMIZE_SIZE', True)) else ''}"
PACKAGECONFIG:append = "${@' static' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_STATIC', True)) else ''}"

