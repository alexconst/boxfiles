#!/bin/bash

# install virtualbox
# x11 related addons depend if Xorg is installed

if [ -f "/usr/bin/Xorg" ]; then
    vbx11="virtualbox-guest-x11"
    nox=""
else
    nox="--nox11"
fi
apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils "$vbx11" --no-install-recommends
apt-get install -y linux-headers-$(uname -r) build-essential perl --no-install-recommends
apt-get install -y dkms

## not required after all
#apt-get install -y virtualbox-guest-additions-iso
#vboxiso="/usr/share/virtualbox/VBoxGuestAdditions.iso"
#mount -o loop "$vboxiso" /mnt
#sh /mnt/VBoxLinuxAdditions.run "$nox"
#umount /mnt

apt-get -y clean
apt-get -y autoremove

# get this folder out of the way since we'll be using vbox share instead of rsync
#mv /vagrant /vagrant_rsync___can_be_deleted
# no longer needed because we disable the vagrant share

