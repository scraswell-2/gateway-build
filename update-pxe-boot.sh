#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TAR=$(which gtar)
UPDATE_ISOS=${1}

ARCHIVE=post-install.tar.gz

if [ -z ${TAR} ]
then
    TAR=$(which tar)
fi

${TAR} -C ${DIR} -czvf ${DIR}/${ARCHIVE} pxe-boot

scp -P 59022 ${DIR}/${ARCHIVE} sean@gateway:/tmp/${ARCHIVE}
rm -v ${DIR}/${ARCHIVE}

ssh -t -p 59022 sean@gateway sudo mkdir -pv /opt/post-install
ssh -t -p 59022 sean@gateway sudo tar -xvf /tmp/${ARCHIVE} --strip-components=1 -C /opt/post-install
ssh -t -p 59022 sean@gateway sudo rm -rf /home/tftp/*
ssh -t -p 59022 sean@gateway sudo /opt/post-install/post-install.sh gateway 1
ssh -t -p 59022 sean@gateway sudo /opt/system-setup/lib/300_setup_pxe_boot.sh

if [ "${UPDATE_ISOS}" = "1" ]
then
    ssh -t -p 59022 sean@gateway sudo /opt/system-setup/lib/301_setup_clonezilla_pxe.sh
    ssh -t -p 59022 sean@gateway sudo /opt/system-setup/lib/302_setup_sysresccd_pxe.sh
fi

ssh -t -p 59022 sean@gateway sudo rm -rf /opt/post-install /opt/system-setup
ssh -t -p 59022 sean@gateway rm -v /tmp/${ARCHIVE}
