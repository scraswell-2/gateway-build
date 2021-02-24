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

SYSRESCCD_URL='https://osdn.net/projects/systemrescuecd/storage/releases/7.01/systemrescue-7.01-amd64.iso'
curl -Lk -o sysresccd.iso ${SYSRESCCD_URL}

7z x sysresccd.iso -osysresccd

find sysresccd -type f -iname "vmlinuz" -exec install -v -D -g tftp -o tftp {} ${TFTP_ROOT}/sysresccd/boot/vmlinuz \;
find sysresccd -type f -iname "sysresccd.img" -exec install -v -D -g tftp -o tftp {} ${TFTP_ROOT}/sysresccd/boot/sysresccd.img \;
find sysresccd -type f -iname "amd_ucode.img" -exec install -v -D -g tftp -o tftp {} ${TFTP_ROOT}/sysresccd/boot/amd_ucode.img \;
find sysresccd -type f -iname "intel_ucode.img" -exec install -v -D -g tftp -o tftp {} ${TFTP_ROOT}/sysresccd/boot/intel_ucode.img \;

find sysresccd -type f -iname "airootfs.sha512" -exec install -v -D -g www-data -o www-data {} ${WEB_ROOT}/sysresccd/x86_64/airootfs.sha512 \;
find sysresccd -type f -iname "airootfs.sfs" -exec install -v -D -g www-data -o www-data {} ${WEB_ROOT}/sysresccd/x86_64/airootfs.sfs \;

rm -rfv sysresccd sysresccd.iso

