############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

PACKAGECONFIG += " \
    sql-mysql \
    ${@'optimize-size' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_OPTIMIZE_SIZE')) else ''} \
    ${@'static' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_STATIC')) else ''} \
    ${@'ltcg' if bb.utils.to_boolean(d.getVar('EMBI_QTBASE_LTCG')) else ''} \
"
