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

PRODUCT_APP_SERVICE_USER ?= "root"
PRODUCT_APP_SERVICE_GROUP ?= "root"

PRODUCT_ROOT_PASSWORD ?= ""
ROOT_LOGIN_PARAMS = "usermod -p '${PRODUCT_ROOT_PASSWORD}' root; usermod -U root;"

EXTRA_USERS_PARAMS = " \
    ${ROOT_LOGIN_PARAMS} \
    "
