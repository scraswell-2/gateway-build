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
apt -y install lighttpd

install -D -d -o www-data -g www-data ${WEB_ROOT}

sed -i 's/\/var\/www\/html/\/home\/www-data/g' /etc/lighttpd/lighttpd.conf

systemctl enable lighttpd.service
##############################################
## end install packages
##############################################

