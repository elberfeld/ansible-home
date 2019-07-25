
## Einrichtung Festplattenverschlüssellung 
Auf den Servern ist das Verzeichnis /srv mit ecryptFS verschlüsselt.

Die Einrichtung hierfür erfolgt manuell.
Bei der Einrichtung muss /srv noch leer sein

### Tools installieren
apt-get -y install ecryptfs-utils

### Crypt mount einrichten 
mount -t ecryptfs /srv /srv
Select key type: passhrase 
Select cipher: aes 
Select key bytes: 16 
Enable plaintext pass: no
Enable filename encryption: yes
Confirm filename encryption key (autogen) >> Signatur merken 
Select proceed mount: yes
Select append sig: yes 

### Crypt-Helper einrichten

Datei: ~/mount_srv.sh (<Signatur> mit der obigen Signatur ersetzen)

```bash
#!/bin/sh
echo "Enter Passphrase to unlock"
mount -t ecryptfs /srv /srv -o rw,noatime,nodiratime,ecryptfs_unlink_sigs,ecryptfs_fnek_sig=<Signatur>,ecryptfs_key_bytes=16,ecryptfs_cipher=aes,ecryptfs_sig=<Signatur>,ecryptfs_passthrough=n,key=passphrase
echo "Starting Services .."
systemctl start docker.socket
systemctl start docker.service
systemctl start containerd.service
systemctl start telegraf.service
systemctl start cron.service
```
### Dienste deaktivieren 

```bash
systemctl disable docker.socket
systemctl disable docker.service
systemctl disable containerd.service
systemctl disable telegraf.service
systemctl disable cron.service
```

### Referenzen
https://www.howtoforge.com/tutorial/how-to-encrypt-directories-and-partitions-with-ecryptfs-on-debian/


