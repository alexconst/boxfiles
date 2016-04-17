#!/bin/bash

# GNU/Linux survival kit
apt-get install -y vim-nox htop tree ncdu
apt-get install -y tmux byobu ccze --no-install-recommends

# pimp my environment
apt-get install -y zsh
sed -i.BAK 's#/bin/bash#/usr/bin/zsh#g' /etc/passwd
apt-get install -y git

# dotfiles
apt-get install -y vcsh mr myrepos ack-grep
# TODO


# developer things
apt-get install -y python3 ipython3


# ansible
apt-get install -y ansible sshpass

