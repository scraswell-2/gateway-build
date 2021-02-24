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
## begin install packages
##############################################
apt -y install bind9

install -D ${DIR}/../files/etc/bind/home-domain-reverse.zone /etc/bind/home-domain-reverse.zone
do_token_replace /etc/bind/home-domain-reverse.zone

install -D ${DIR}/../files/etc/bind/home-domain.zone /etc/bind/home-domain.zone
do_token_replace /etc/bind/home-domain.zone

install -D ${DIR}/../files/etc/bind/named.conf.local /etc/bind/named.conf.local
do_token_replace /etc/bind/named.conf.local

install -D ${DIR}/../files/etc/bind/named.conf.options /etc/bind/named.conf.options
do_token_replace /etc/bind/named.conf.options

systemctl enable bind9.service
##############################################
## end install packages
##############################################