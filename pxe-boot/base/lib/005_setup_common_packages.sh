#!/bin/bash
##############################################
## dot sourcing
##############################################
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. ${DIR}/config
. ${DIR}/functions
##############################################
## end dot sourcing
##############################################

##############################################
## get required config pacakges
##############################################
apt update
apt -y install htop curl unzip p7zip-full net-tools dnsutils

##############################################
## end get required config pacakges
##############################################