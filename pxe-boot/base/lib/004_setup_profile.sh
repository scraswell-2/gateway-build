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
## setup /etc/skel/.profile
##############################################
cat /etc/skel/.profile > /tmp/.profile

cat > /tmp/.profile-appendix << "EOF"

EDITOR="vim"

if [[ -f "$HOME/.generated_passwd" ]]
then
echo ""
echo -e "\e[1m[\e[0mWARNING\e[1m]\e[0m You have a \e[1mgenerated\e[0m password."
echo -e "Please review $HOME/.generated_passwd and \e[33mchange\e[0m your password.  Deleting $HOME/.generated_passwd will remove this message."
echo ""
fi
EOF

cat /tmp/.profile /tmp/.profile-appendix > /etc/skel/.profile

rm /tmp/.profile /tmp/.profile-appendix
##############################################
## end setup /etc/skel/.profile
##############################################