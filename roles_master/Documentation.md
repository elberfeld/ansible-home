
TODO:

Udev-Rule für Nabu Casa Skyconnect 

root@master:~# cat /etc/udev/rules.d/99-usb-serial.rules
SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60" SYMLINK+="ttyNabuCasaSkyConnect" KERNEL=="ttyUSB[0-9]*",MODE="0666"

