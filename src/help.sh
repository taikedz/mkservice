### A utility for making systemd services Usage:help
#
# Command structure
#
# 	mkservice -s SERVICENAME -d DESCRIPTION [OPTIONS ...] -- COMMAND ...
#
# Mandatory options
# -----------------
#
# -d DESCRIPTION
# 	A short description for the service
#
# -n SERVICENAME
# 	The name of the service - this should be an alphanumeric string
# 
# -- COMMAND ...
#   The literal command to run as a service
#
# Additional options
# ------------------
#
# -u USERNAME
# 	The name of the user to run the service as.
# 	Default is "nobody"
#
# -r RESTARTPOLICY
# 	When to restart the service - available modes are
# 		no
# 		on-success
# 		on-failure
# 		on-abnormal
# 		on-watchdog
# 		on-abort
# 		always
# 	Default is "always"
#
# -a AFTER
# 	Set the target to start your service after
# 	Default is "network.target"
#
# -w WANTEDBY
# 	Set a target to start your service before
# 	Default is "default.target"
#
# --overwrite
# 	If the service file already exists, overwrite without prompting
#
# -f FILEPATH
# 	Choose a different destination to write the file to
#
###/doc

#%include std/autohelp.sh
