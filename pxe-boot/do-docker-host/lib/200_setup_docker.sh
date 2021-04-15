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
## install docker
##############################################
apt -y install gnupg

TEMP_KEY=$(mktemp)
TEMP_KEYRING=$(mktemp)

curl -Ls -o "${TEMP_KEY}" https://download.docker.com/linux/debian/gpg
gpg --no-default-keyring --keyring "${TEMP_KEYRING}" --import "${TEMP_KEY}"
install -o root -g root -m 0644 "${TEMP_KEYRING}" /etc/apt/trusted.gpg.d/docker-ce.gpg

rm -v "${TEMP_KEYRING}"
rm -v "${TEMP_KEY}"

cat > /etc/apt/sources.list.d/docker.list << "EOF"
deb [arch=amd64] https://download.docker.com/linux/debian buster stable
EOF

apt -y update && apt -y install docker-ce docker-compose

PRIVATE_IP=$(ip -o addr show dev eth1 | grep -v inet6 | awk '{print $4}' | sed 's/^\(.*\)\/.*/\1/g')

sleep 10

docker swarm init --advertise-addr $PRIVATE_IP
##############################################
