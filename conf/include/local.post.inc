############################################################################
##
## This file is part of the meta-embi layer.
##
############################################################################

BB_NUMBER_THREADS = "6"
BB_NICE_LEVEL ??= "19"
BB_TASK_NICE_LEVEL ??= "19"
BB_TASK_IONICE_LEVEL ??= "3.7"

# include boot2qt config
include conf/include/boot2qt.inc

# include rpi config
include conf/include/rpi.inc

# include user config
include conf/include/user.inc
