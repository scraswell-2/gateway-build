#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
UPDATE_ISOS=${1}

GIT_URL="https://github.com/scraswell-2/gateway-build.git"
RECONF_DIR="/opt/system-reconfiguration"
SYSTEM_SETUP_DIR="/opt/system-setup"
TFTP_HOME="/home/tftp"
PRESEEDS_DIR="${TFTP_HOME}/preseeds"
DEBIAN_INSTALLER_DIR="${TFTP_HOME}/debian-installer"

git clone "${GIT_URL}" "${RECONF_DIR}" || { echo "Failed to clone repo."; exit 1; }

if [ "${UPDATE_ISOS}" = "1" ]
then
    rm -rf "${TFTP_HOME}"
else
    rm -rf "${PRESEEDS_DIR}" "${DEBIAN_INSTALLER_DIR}"
fi

${RECONF_DIR}/pxe-boot/post-install.sh gateway 1
${SYSTEM_SETUP_DIR}/lib/300_setup_pxe_boot.sh

if [ "${UPDATE_ISOS}" = "1" ]
then
    ${SYSTEM_SETUP_DIR}/lib/301_setup_clonezilla_pxe.sh
    ${SYSTEM_SETUP_DIR}/lib/302_setup_sysresccd_pxe.sh
fi

rm -rf "${RECONF_DIR}" "${SYSTEM_SETUP_DIR}"
