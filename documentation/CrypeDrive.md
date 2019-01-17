
# Dokumentation Vorstands-VM
Die Vorstands-VM ist ein Arbeitsrechner für Vorstandsarbeiten.
Da hier sensible Daten liegen haben nur die aktiven Vorstandsmitglieder zugriff auf diesen Server. 

Jameica/JVerein ist auf diesem Server lokal installiert.
Der Zugriff auf Jameica erfolgt über X2go, hierfür wird der X2go Client benötigt.
Für die datenhaltung von Jameica ist ein lokaler MySQL Server installiert.

## TODOS

- UAT Jameica über X2go 
- X2go Client einrichtung 
- Klärung: ein User oder getrennte User ? (Eine oder getrennte Sessions ?)
- Klärung: Nextcloud Instanz sinnvoll ? (Datenfreigabe für steuerberater, Datenfreigabe für Helfer)
- Installation LDAP 
- Installation Kanboard  
- Installation GitTea 
- Weitere Administrative Tools ?

## Einrichtung Festplattenverschlüssellung 
Auf der Vorstands-VM ist das Verzeichnis /srv mit ecryptFS verschlüsselt.

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
echo "Select option 2 and enter Passphrase"
mount -t ecryptfs /srv /srv -o rw,noatime,nodiratime,ecryptfs_unlink_sigs,ecryptfs_fnek_sig=<Signatur>,ecryptfs_key_bytes=16,ecryptfs_cipher=aes,ecryptfs_sig=<Signatur>,ecryptfs_passthrough=n
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


