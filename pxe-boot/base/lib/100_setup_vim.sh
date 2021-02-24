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
## get required config pacakges
##############################################
apt -y install vim
##############################################
## end get required config pacakges
##############################################

##############################################
## configure
##############################################
cat > /etc/skel/.vimrc << "EOF"
:set encoding=utf-8
:set tabstop=4
:set shiftwidth=4
:set softtabstop=4
:set expandtab
:set nowrap
:set number
:set ruler
:set nobackup
:set noundofile
:set smartindent
:filetype indent on
:syntax on
EOF

cp -v /etc/skel/.vimrc /root/.vimrc

##############################################
## end configure
##############################################