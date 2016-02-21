# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|

  # Debian Jessie + VirtualBox Addons 
  config.vm.box = "debian/contrib-jessie64"

  # Customize 
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Vagrant-AnsibleHome"
	vb.memory = "512"
	vb.cpus = 2
	vb.linked_clone = true
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list
    echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list
    sudo apt-get update
	sudo apt-get upgrade -y
    sudo apt-get install -y python python-pip python-dev
    sudo pip install ansible  
  SHELL

  config.vm.synced_folder ".", "/home/vagrant"

  # Enable Aent forwarding   
  config.ssh.forward_agent = true 
     
end
