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
apt -y install tftpd-hpa

install -D -d -o tftp -g tftp ${TFTP_ROOT}

install -D ${DIR}/../files/etc/default/tftpd-hpa \
    /etc/default/tftpd-hpa

do_token_replace /etc/default/tftpd-hpa

systemctl enable tftpd-hpa.service
##############################################
## end install packages
##############################################
