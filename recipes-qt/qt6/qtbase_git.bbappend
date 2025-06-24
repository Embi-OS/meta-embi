############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

PACKAGECONFIG += " \
    sql-mysql \
    ${@'ltcg' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_LTCG')) else ''} \
    ${@'optimize-size' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_OPTIMIZE_SIZE')) else ''} \
    ${@'static' if bb.utils.to_boolean(d.getVar('ENABLE_QTBASE_STATIC')) else ''} \
"

