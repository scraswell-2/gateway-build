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
NICINDEX=0

ip -o link | grep -v lo: | awk '{print $(NF-2)}' | while read MAC
do
cat > /etc/systemd/network/2${NICINDEX}-lan${NICINDEX}.network << EOF
[Match]
Name=lan${NICINDEX}

[Network]
Bridge=br0
EOF
    let "NICINDEX+=1"
done

cat > /etc/systemd/network/99-br0.network << "EOF"
[Match]
Name=br0

[Network]
DHCP=yes
EOF

systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
##############################################
## end configure interfaces
##############################################