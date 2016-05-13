# About

VirtualBox guest tools make file syncing and networking easy. However official Debian images don't include them since they're on the contrib repos.

So to get things running smoothly some manual intervention is required:
1. comment any `config.vm.provision "shell", path: "provision/` lines that are not relevant to your interests. In most cases this would boil down to either including or not including `.../02_x11.sh`
1. comment the `config.vm.synced_folder` line blocks (there are two!) in the Vagrantfile
1. run `vagrant up`
1. uncomment the `config.vm.synced_folder` line blocks
1. eventually uncomment or add any `config.vm.network` lines of interest
1. run `vagrant reload` (equivalent to `vagrant halt ; vagrant up`)

To avoid having to do this (and waiting 10+ minutes) every time:
```bash
# package the box:
boxname="Debian8_w_VirtualBox_guest_tools.box"
vagrant package --output $boxname
# add it to your image pool:
vagrant box add $boxname
# and update the Vagrantfile to use the new image the next time:
sed -i.BAK 's/\(\s*config\.vm\.box\s*=\).*/\1 "'$boxname'"/g  ;  s/\(\s*\)\(config\.vm\.provision.*\)/\1#\2/g' Vagrantfile
```
The next time you want to start a new environemnt, as always, simply `vagrant up`.



