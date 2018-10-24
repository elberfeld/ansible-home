
# Proxmox Server mit VLANs

Bei der Installation nur ein Netzwerkinterface aktiv, hier die zukünftig interne IP setzen 
Korrekte einträge in /etc/hosts beachten 
Actung bei Einrichtung: Proxmox legt Datei in /etc/apt/sources.lists.d/ an 

# vmbrX in Proxmox Konfigurieren (eine pro VLAN)

Interne IP vergeben (nur LAN Netz) 
Autostart: Ja
VLAN Aware: Nein 
Bridge Ports: eno1.100 (Interface mit VLAN Zusatz)

# VM Einrichtung 

Nur Bridge Interface zuordnen, ohne VLAN Tag 
