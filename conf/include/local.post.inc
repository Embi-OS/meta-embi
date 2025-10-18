############################################################################
##
## Config file related to bitbake
##
############################################################################

# default bitbake variables
BB_NUMBER_THREADS = "6"
BB_NICE_LEVEL ??= "19"
BB_TASK_NICE_LEVEL ??= "19"
BB_TASK_IONICE_LEVEL ??= "3.7"

# include boot2qt config
include conf/include/boot2qt.inc

# include board config
include conf/include/board.inc

# include user config
include conf/include/user.inc

# include swupdate config
include conf/include/swupdate.inc
