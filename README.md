# About

*Vagrantfile for creating a Debian box with VirtualBox guest tools installed.*

VirtualBox guest tools make file syncing and networking easy. However official Debian images don't include them since they're on the contrib repos.
So to get things running smoothly we need to do some work.


**Step 1: start a new environment**

This will execute the provisioning scripts which will install the VirtualBox tools and allow for shared folders and networking.

1. optionally comment any `config.vm.provision "shell", path: "provision/` lines that are not relevant to your interests. In most cases this would boil down to either including or not including `.../02_x11.sh` (tip: if you're using X then you may want to uncomment `vb.gui = true`)
1. run `vagrant up`

If you want to use the environment right away, with network and shared folders, before saving the box:

1. eventually tweak the `config.vm.network` and `config.vm.synced_folder` lines of interest
1. run `BOX="dummy" vagrant reload` (equivalent to `vagrant halt ; BOX="dummy" vagrant up`)


**Step 2: package it into a box**

This will avoid having to wait 10+ minutes for the the provisioning to finish each time you do `vagrant up`.
So after doing the steps above, do the following:

```bash
# package the box:
boxname="Debian8_w_VirtualBox_guest_tools"
vagrant package --output "${boxname}.box"
# add it to your image pool:
vagrant box add "${boxname}.box" --name "${boxname}"
# save the boxname so that Vagrantfile will read from it
echo "${boxname}" > box
```


**Step 3: use the new box that was already provisioned**

From now on simply `vagrant up`.


