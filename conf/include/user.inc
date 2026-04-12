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

# Hash generated with:
# printf "%q" "$(mkpasswd -m sha256crypt admin)"
PRODUCT_ADMIN_USER ?= "service.embi"
PRODUCT_ADMIN_PASSWORD ?= "\$5\$LWOHE2xQwtYylBsf\$XAGjjCRLmd37kHqAueeup75caWxBf.1tRHtZS8Z/EwB"
PRODUCT_APP_SERVICE_USER ?= "root"
PRODUCT_APP_SERVICE_GROUP ?= "root"

PRODUCT_ROOT_PASSWORD ?= ""
ROOT_LOGIN_PARAMS = "usermod -p '${PRODUCT_ROOT_PASSWORD}' root; usermod -L root;"

EXTRA_USERS_PARAMS = " \
    useradd -p '${PRODUCT_ADMIN_PASSWORD}' -m -s /bin/sh ${PRODUCT_ADMIN_USER}; \
    ${ROOT_LOGIN_PARAMS} \
    "
