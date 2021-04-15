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
## begin install packages
##############################################
apt -y install knockd

install -D ${DIR}/../files/etc/knock/knockd.conf /etc/knock/knockd.conf
install -D ${DIR}/../files/etc/systemd/system/knockd.service /etc/systemd/system/knockd.service

systemctl enable knockd.service
##############################################
## end install packages
##############################################