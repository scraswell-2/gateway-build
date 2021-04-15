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
## configure user
##############################################
USERNAME=${ADMIN_USER_NAME}
SSH_FOLDER="/home/${USERNAME}/.ssh"
USER_KEY_FILE="${SSH_FOLDER}/id_rsa"
AUTH_KEYS_FILE="${SSH_FOLDER}/authorized_keys"

useradd --user-group --groups sudo --create-home --shell /bin/bash ${USERNAME}
mkdir -p "${SSH_FOLDER}"

cat > "${AUTH_KEYS_FILE}" << EOF
${ADMIN_USER_PUBKEY}
EOF

chown -Rv ${USERNAME}:${USERNAME} "${SSH_FOLDER}"
chmod -v 0700 "${SSH_FOLDER}"
chmod -v 0600 "${AUTH_KEYS_FILE}"

USERPW=$(gen_passwd)
echo "${USERNAME}:${USERPW}" | chpasswd
echo "${USERPW}" > "/home/${USERNAME}/.generated_passwd"
##############################################
## end configure user
##############################################


##############################################
## add user to docker group
##############################################
usermod -G docker --append ${ADMIN_USER_NAME}
##############################################

