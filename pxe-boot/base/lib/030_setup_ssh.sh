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
## begin setup ssh
##############################################
apt -y install openssh-server

sed -i \
    -e 's/^#Port 22.*$/Port 59022/g' \
    -e 's/^#PermitRootLogin prohibit-password.*$/PermitRootLogin no/g' \
    /etc/ssh/sshd_config

systemctl enable sshd.service
##############################################
## end setup ssh
##############################################