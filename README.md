# Warpzone Infrastruktur Konfiguration

Die Infrastruktur wird nach und nach durch das Konfigurationstool Ansible aufgebaut.
Diese Konfiguration soll als zentrale Dokumentation dienen.

## Aktueller Status

Alle Server sind erfasst

## Vorraussetzungen
Installiertes ansible

```
apt install python3 python3-pip python3-netaddr ansible ansible-lint
```

Ausführen von

```
ansible-galaxy collection install community.docker
```

## Benutzung

Ausführen von Rollen per
```
ansible-playbook -i hosts.yml site.yml -l webserver -t hackmd
```

mit -l wird der hosts eingeschränkt mit -t der tag bzw die Rolle, alle tags stehen in der site.yml

