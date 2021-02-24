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
WANCONFIGURED=0

ip -o link | grep -v lo: | awk '{print $(NF-2)}' | while read MAC
do
    if [ "${WANCONFIGURED}" = "0" ]
    then
cat > /etc/systemd/network/10-wan${NICINDEX}.link << EOF
[Match]
MACAddress=${MAC}

[Link]
Name=wan${NICINDEX}
EOF
      WANCONFIGURED=1
    else
cat > /etc/systemd/network/2${NICINDEX}-lan${NICINDEX}.link << EOF
[Match]
MACAddress=${MAC}

[Link]
Name=lan${NICINDEX}
EOF
    let "NICINDEX+=1"
    fi
done
##############################################
## end configure interfaces
##############################################