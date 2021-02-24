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

cat > /etc/systemd/network/20-lan0.network << EOF
[Match]
Name=lan0

[Network]
Address=${LAN_OCTETS}.4/24
Gateway=${LAN_OCTETS}.1
DNS=${LAN_OCTETS}.1
EOF

systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
##############################################
## end configure interfaces
##############################################