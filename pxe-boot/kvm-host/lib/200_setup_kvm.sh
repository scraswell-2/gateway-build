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
## install kvm
##############################################
apt -y install \
        --no-install-recommends \
        qemu-kvm \
        ovmf
##############################################
## end install kvm
##############################################
