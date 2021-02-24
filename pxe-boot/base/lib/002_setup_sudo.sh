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
## install and configure sudo
##############################################
apt -y install sudo

cat > /etc/sudoers.d/10_sudo << "EOF"
%sudo ALL=(ALL:ALL) ALL
EOF
##############################################
## end install and configure sudo
##############################################