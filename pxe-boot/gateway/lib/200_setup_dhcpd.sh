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
apt -y install isc-dhcp-server

install -D ${DIR}/../files/etc/default/isc-dhcp-server /etc/default/isc-dhcp-server

install -D ${DIR}/../files/etc/gateway/dhcpd.conf /etc/gateway/dhcpd.conf
do_token_replace /etc/gateway/dhcpd.conf

systemctl enable isc-dhcp-server.service

install -Dv ${DIR}/../files/usr/local/sbin/update-dhcp-server.sh \
    /usr/local/sbin/update-dhcp-server.sh
##############################################
## end install packages
##############################################
