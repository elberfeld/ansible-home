
rem Vagrant VM Starten 
vagrant up 

rem SSH Verbindung über PuTTY mit https://github.com/nickryand/vagrant-multi-putty
vagrant putty -- -l vagrant -pw vagrant

pause

rem Vagrant VM Stoppen 
vagrant halt