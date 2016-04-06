#!/bin/bash

# GNU/Linux survival kit
apt-get install -y vim-nox htop
apt-get install -y tmux byobu ccze --no-install-recommends


# pimp my environment
apt-get install -y zsh
#user1000=`awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd`
#chsh -s `which zsh` "$user1000"
sed -i.BAK 's#/bin/bash#/usr/bin/zsh#g' /etc/passwd
apt-get install -y git
# TODO: git clone path-to-my-dotfiles


# developer things
apt-get install -y python3 ipython3


# ansible
apt-get install -y ansible sshpass

