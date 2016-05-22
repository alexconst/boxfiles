#!/bin/bash

# GNU/Linux survival kit
apt-get install -y vim-nox
apt-get install -y htop tree ncdu tmux byobu ccze --no-install-recommends
apt-get install -y zsh
sed -i.BAK 's#/bin/bash#/usr/bin/zsh#g' /etc/passwd
apt-get install -y git exuberant-ctags
apt-get install -y ack silversearcher-ag --no-install-recommends
apt-get install -y stow --no-install-recommends
apt-get install -y msort --no-install-recommends


# developer things
apt-get install -y python3 ipython3


# ansible
apt-get install -y ansible sshpass

