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
cat > /etc/systemd/network/2${NICINDEX}-lan${NICINDEX}.link << EOF
[Match]
MACAddress=${MAC}

[Link]
Name=lan${NICINDEX}
EOF
    let "NICINDEX+=1"
done
##############################################
## end configure interfaces
##############################################