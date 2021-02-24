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
## get required config pacakges
##############################################
cat > /etc/apt/sources.list.d/001_contrib_nonfree.list << "EOF"
deb  http://mirror.csclub.uwaterloo.ca/debian buster contrib non-free
deb-src  http://mirror.csclub.uwaterloo.ca/debian buster contrib non-free

deb http://security.debian.org/ buster/updates contrib non-free
deb-src http://security.debian.org/ buster/updates contrib non-free
EOF

apt update && apt -y install amd64-microcode intel-microcode
##############################################
## end get required config pacakges
##############################################