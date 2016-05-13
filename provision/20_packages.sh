#!/bin/bash

# GNU/Linux survival kit
apt-get install -y vim-nox htop tree ncdu
apt-get install -y tmux byobu ccze --no-install-recommends

# optimize environment
apt-get install -y zsh
sed -i.BAK 's#/bin/bash#/usr/bin/zsh#g' /etc/passwd
apt-get install -y git
apt-get install -y stow --no-install-recommends
apt-get install -y msort --no-install-recommends



# developer things
apt-get install -y python3 ipython3


# ansible
apt-get install -y ansible sshpass

