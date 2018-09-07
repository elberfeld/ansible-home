
Vagrant.configure(2) do |config|

  # Debian Jessie + VirtualBox Addons 
  config.vm.box = "debian/contrib-stretch64"

  # Hostname
  config.vm.hostname = "box"
  
  # Customize 
  config.vm.provider "virtualbox" do |vb|
	vb.memory = "512"
	vb.cpus = 2
	vb.linked_clone = true
  end

  # Enable Agent forwarding   
  config.ssh.forward_agent = true 
  
  config.vm.provision "shell", inline: <<-SHELL

	echo "######################################################"
	echo "Setup Debian Testing ..."
	echo "######################################################"

	echo "deb http://httpredir.debian.org/debian testing main contrib non-free" > /etc/apt/sources.list
	echo "deb http://security.debian.org/ testing/updates main contrib non-free" >> /etc/apt/sources.list
	
	sudo apt-get update

	# Avoid service sestart question if libc is upgraded
	echo 'libc6 libraries/restart-without-asking boolean true' | sudo debconf-set-selections

	echo "######################################################"
	echo "Installing Vim ..."
	echo "######################################################"

	sudo apt-get install -y vim
	
	echo "######################################################"
	echo "Installing Git ..."
	echo "######################################################"

	sudo apt-get install -y git
	
 	echo "######################################################"
    echo "Installing Fish Shell ..."
    echo "######################################################"

    sudo apt-get install -y fish
	
	# Set FiSH Shell as default Login Shell
	sudo chsh -s /usr/bin/fish vagrant
	
	# Create a FiSH base config 
	mkdir -p -v /home/vagrant/.config/fish/
	curl https://raw.githubusercontent.com/elberfeld/fish/master/config.fish > /home/vagrant/.config/fish/config.fish
	chown vagrant:vagrant -v -R /home/vagrant/.config 
	
	# Change to /vagrant/ directory on Login 
    echo "cd /vagrant/" >> /home/vagrant/.config/fish/config.fish 

	echo "######################################################"
	echo "Installing Ansible ..."
	echo "######################################################"
		
	sudo apt-get install -y python python-pip python-dev libffi6 libffi-dev libssl-dev sshpass
	sudo pip install ansible markupsafe netaddr

    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config  
    
    echo "[defaults]" > /home/vagrant/.ansible.cfg
    echo "inventory = /vagrant/hosts" >> /home/vagrant/.ansible.cfg

	echo "######################################################"
	echo "DONE"
	echo "######################################################"
	
  SHELL
     
end
