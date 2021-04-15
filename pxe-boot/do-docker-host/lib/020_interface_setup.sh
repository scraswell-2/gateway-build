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
## begin configure interfaces
##############################################

install -D ${DIR}/../files/etc/systemd/system/firewall.service /etc/systemd/system/firewall.service

install -D -m 0744 ${DIR}/../files/usr/local/sbin/firewall /usr/local/sbin/firewall

systemctl enable firewall.service
##############################################
## end configure interfaces
##############################################