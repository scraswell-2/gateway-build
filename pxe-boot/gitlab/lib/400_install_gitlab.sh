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

apt -y install curl openssh-server ca-certificates perl

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash

EXTERNAL_URL="https://gitlab.at.home" apt install -y gitlab-ce

mkdir -pv /etc/gitlab/ssl

curl -L -o /etc/gitlab/ssl/gitlab.at.home.crt "http://gateway.at.home/certs/gitlab.at.home.crt"
curl -L -o /etc/gitlab/ssl/gitlab.at.home.key "http://gateway.at.home/certs/gitlab.at.home.key"

touch /etc/gitlab/.not_configured

install -D ${DIR}/../files/etc/systemd/system/gitlab-first-run.service \
    /etc/systemd/system/gitlab-first-run.service

install -D -m 0744 ${DIR}/../files/usr/local/sbin/gitlab-first-run \
    /usr/local/sbin/gitlab-first-run

