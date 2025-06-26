############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

EXTRA_IMAGE_FEATURES:append = " \
    allow-empty-password \
    allow-root-login \
    empty-root-password \
    "

inherit extrausers

# Hash generated with "printf "%q" $(mkpasswd -m sha256crypt <password>)"

EMBI_ROOT_PASSWORD ?= ""
BB_ENV_PASSTHROUGH_ADDITIONS += " \
    EMBI_ROOT_PASSWORD \
    "

EXTRA_USERS_PARAMS = " \
    usermod -p '${EMBI_ROOT_PASSWORD}' root; \
    "
