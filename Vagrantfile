# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # NOTE: if a box is defined via environment variable 'BOX' or file 'box',
  # then it will use it and assume it has already been provisioned.
  #
  # select box from environment variable
  box = ENV['BOX']
  box ||= ''
  # if empty, then read from existing file
  filename = 'box'
  if box == '' and File.file?(filename)
    box = File.read(filename).strip
  end
  # if no box is defined, then fallback to debian (and do the provisioning)
  if box == ''
    new_install = true
    config.vm.box = "debian/jessie64"
    # Ubuntu comes with the VBox guest tools already installed
    #config.vm.box = "ubuntu/wily64"
  else
    new_install = false
    config.vm.box = box
  end

  # Set up hostname
  config.vm.hostname = "nostromo"
  # Message shown on vagrant up
  config.vm.post_up_message = ""


  if ! new_install
    # configure a private network using DHCP, so it's accessible to the host and other guests
    config.vm.network "private_network", type: "dhcp"
    # Assign a static IP to the guest
    #config.vm.network "private_network", ip: "192.168.1.10"
    # Create a forwarded port mapping
    #config.vm.network "forwarded_port", guest: 80, host: 8080
  end

  # Force not-using rsync, so it can fallback to virtualbox sync folders
  # https://superuser.com/questions/1022926/how-to-script-install-of-virtualbox-guest-additions-to-a-vagrant-debian-box/1025183#1025183
  # http://jeremykendall.net/2013/08/09/vagrant-synced-folders-permissions/
  if new_install
    # disable shared folders during the creation/provisioning of a new box/environment
    config.vm.synced_folder "./", "/vagrant", disabled: true
  else
    config.vm.synced_folder "./", "/vagrant", id: "vagrant-root",
      owner: "vagrant",
      group: "vagrant",
      mount_options: ["dmode=775"],
      type: ""
    # Share an additional folder with the guest VM.
    host_folder = ENV['HOME'] + "/home/downloads/share_vagrant"
    guest_folder = "/shared/"
    config.vm.synced_folder host_folder, guest_folder
  end

  # Fine tune the virtualbox VM
  config.vm.provider "virtualbox" do |vb|
    vb.customize [
      "modifyvm", :id,
      "--cpus", "2",
      "--cpuexecutioncap", "50",
      "--memory", "512",
    ]
    # uncomment the next line if you want to use a GUI
    #vb.gui = true
  end



  if new_install
    # fix annoyance, http://foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
    config.vm.provision "fix-no-tty", type: "shell" do |s|
      s.privileged = false
      s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
    end
    # fix annoyance, http://serverfault.com/questions/500764/dpkg-reconfigure-unable-to-re-open-stdin-no-file-or-directory
    config.vm.provision "shell", inline: "echo 'export DEBIAN_FRONTEND=noninteractive' >> /root/.profile"
    config.vm.provision "shell", inline: "for user in /home/*; do echo 'export DEBIAN_FRONTEND=noninteractive' >> $user/.profile; done"


    # do the provisioning
    config.vm.provision "shell", path: "provision/00_base.sh"
    config.vm.provision "shell", path: "provision/01_updates.sh"
    # uncomment this line if you want X11 i3:
    #config.vm.provision "shell", path: "provision/02_x11.sh"
    config.vm.provision "shell", path: "provision/10_virtualbox.sh"
    config.vm.provision "shell", path: "provision/20_packages.sh"
    config.vm.provision "shell", path: "provision/90_cleanup.sh"


    # ignore this section
    ## provisioning using Ansible
    #config.vm.provision "ansible" do |ansible|
    #  ansible.playbook = "example.yml"
    #  ansible.inventory_path = "example.ini"
    #  # when using an inventory file, the path to the private key must also be specified
    #  # either as an argument or in the inventory file itself (which it is)
    #  #ansible.raw_arguments  = [
    #  #  "--private-key=./.vagrant/machines/default/virtualbox/private_key"
    #  #]
    #end
  end


end


