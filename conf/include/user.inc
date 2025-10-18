############################################################################
##
## Config file related to user
##
############################################################################

EXTRA_IMAGE_FEATURES:append = " \
    allow-empty-password \
    allow-root-login \
    empty-root-password \
    "

inherit extrausers

# Hash generated with "printf "%q" $(mkpasswd -m sha256crypt <password>)"

PRODUCT_ROOT_PASSWORD ?= ""

EXTRA_USERS_PARAMS = " \
    usermod -p '${PRODUCT_ROOT_PASSWORD}' root; \
    "
