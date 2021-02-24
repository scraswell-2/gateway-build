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

CLONEZILLA_URL='https://osdn.net/frs/redir.php?m=jaist&f=clonezilla%2F74519%2Fclonezilla-live-2.7.1-22-amd64.zip'
curl -Lk -o clonezilla.zip ${CLONEZILLA_URL}

mkdir -v clonezilla
unzip ./clonezilla.zip -d ./clonezilla

find clonezilla -type f -iname "vmlinuz" -exec install -v -D -g tftp -o tftp {} ${TFTP_ROOT}/clonezilla/vmlinuz \;
find clonezilla -type f -iname "initrd.img" -exec install -v -D -g tftp -o tftp {} ${TFTP_ROOT}/clonezilla/initrd.img \;

find clonezilla -type f -iname "filesystem.squashfs" -exec install -v -D -g www-data -o www-data {} ${WEB_ROOT}/clonezilla/filesystem.squashfs \;

rm -rfv clonezilla clonezilla.zip
