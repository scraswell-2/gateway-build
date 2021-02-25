#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
UPDATE_ISOS=${1}

GIT_URL="https://github.com/scraswell-2/gateway-build.git"
RECONF_DIR="/opt/system-reconfiguration"
SYSTEM_SETUP_DIR="/opt/system-setup"

git clone "${GIT_URL}" "${RECONF_DIR}" || { echo "Failed to clone repo."; exit 1; }

${RECONF_DIR}/pxe-boot/post-install.sh gateway 1
${SYSTEM_SETUP_DIR}/lib/201_setup_bind.sh

rndc reload

rm -rf "${RECONF_DIR}" "${SYSTEM_SETUP_DIR}"
