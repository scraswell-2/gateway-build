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

apt -y install isc-dhcp-client ethtool

##############################################
## begin configure interfaces
##############################################
NICINDEX=0
WANCONFIGURED=0

ip -o link | grep -v lo: | awk '{print $(NF-2)}' | while read MAC
do
    if [ "${WANCONFIGURED}" = "0" ]
    then

cat > /etc/systemd/network/10-wan${NICINDEX}.network << EOF
[Match]
Name=wan${NICINDEX}

[Link]
Unmanaged=yes
EOF
      WANCONFIGURED=1

    else

cat > /etc/systemd/network/2${NICINDEX}-lan${NICINDEX}.network << EOF
[Match]
Name=lan${NICINDEX}

[Link]
Unmanaged=yes
EOF

        let "NICINDEX+=1"

    fi
done


install -D ${DIR}/../files/etc/gateway/dhclient.conf /etc/gateway/dhclient.conf
do_token_replace /etc/gateway/dhclient.conf

install -D ${DIR}/../files/etc/systemd/system/gateway-interfaces.service /etc/systemd/system/gateway-interfaces.service
install -D ${DIR}/../files/etc/systemd/system/gateway-firewall.service /etc/systemd/system/gateway-firewall.service
install -D ${DIR}/../files/etc/systemd/system/gateway-internet.service /etc/systemd/system/gateway-internet.service

install -D -m 0744 ${DIR}/../files/usr/local/sbin/gateway-interfaces /usr/local/sbin/gateway-interfaces
do_token_replace /usr/local/sbin/gateway-interfaces

install -D -m 0744 ${DIR}/../files/usr/local/sbin/gateway-firewall /usr/local/sbin/gateway-firewall
install -D -m 0744 ${DIR}/../files/usr/local/sbin/gateway-internet /usr/local/sbin/gateway-internet

systemctl enable systemd-networkd.service
systemctl enable gateway-interfaces.service
systemctl enable gateway-firewall.service
systemctl enable gateway-internet.service
##############################################
## end configure interfaces
##############################################