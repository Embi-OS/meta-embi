############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

DEFAULT_LOCALE ?= "fr_CH"

do_install:append() {
    sed -i '/LANG=/ c\LANG=${DEFAULT_LOCALE}' ${D}${sysconfdir}/locale.conf
}
