
rem Vagrant VM für Ansible Arbeitsumgebung 
rem Unter Windows müssen die folgenden Git-Einstellungen 
rem gesetzt werden damit die Dateien lokal mit LF als Dateiendungen 
rem vorliegen:
rem $ git config core.eol lf
rem $ git config core.autocrlf input

rem Vagrant VM Starten 
vagrant up 

rem SSH Verbindung über PuTTY mit https://github.com/nickryand/vagrant-multi-putty
vagrant putty -- -l vagrant -pw vagrant

pause

rem Vagrant VM Stoppen 
vagrant halt
