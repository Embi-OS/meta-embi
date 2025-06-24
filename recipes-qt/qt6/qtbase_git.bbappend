############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

PACKAGECONFIG:append = "\
    ${@' ltcg' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_LTCG', True)) else ''} \
    ${@' optimize-size' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_OPTIMIZE_SIZE', True)) else ''} \
    ${@' static' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_STATIC', True)) else ''} \
    sql-mysql \
    "
