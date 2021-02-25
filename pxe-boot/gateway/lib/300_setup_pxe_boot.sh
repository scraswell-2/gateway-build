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

NETBOOT_URL='https://mirror.csclub.uwaterloo.ca/debian/dists/stable/main/installer-amd64/current/images/netboot/netboot.tar.gz'
NETBOOT_FILE=/tmp/netboot.tar.gz

curl -Lk -o ${NETBOOT_FILE} ${NETBOOT_URL}
sudo tar -xvf ${NETBOOT_FILE} -C ${TFTP_ROOT}
rm -v ${NETBOOT_FILE}

install -Dv ${DIR}/../files${TFTP_ROOT}/debian-installer/amd64/boot-screens/txt.cfg \
    ${TFTP_ROOT}/debian-installer/amd64/boot-screens/txt.cfg

do_token_replace ${TFTP_ROOT}/debian-installer/amd64/boot-screens/txt.cfg

install -Dv ${DIR}/../files${TFTP_ROOT}/debian-installer/amd64/grub/grub.cfg \
    ${TFTP_ROOT}/debian-installer/amd64/grub/grub.cfg

do_token_replace ${TFTP_ROOT}/debian-installer/amd64/grub/grub.cfg

find ${DIR}/../preseeds -type f -iname "*.cfg" | while read PRESEED_FILE
do
    DESTINATION_FILE="${TFTP_ROOT}/preseeds/$(basename ${PRESEED_FILE})"

    install -Dv ${PRESEED_FILE} ${DESTINATION_FILE}
done

find ${TFTP_ROOT} -exec chown -v tftp:tftp {} \;
