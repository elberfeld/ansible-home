
# HACS einrichten 

* Webseite: https://hacs.xyz/

HACS muss einmalig manuell im Container installiert werden:

```
docker compose exec app bash
wget -O - https://get.hacs.xyz | bash -
exit
```

Anschließend muss die Integration HACS hinzugefügt werden.
Eine Anmeldung bei GitHub ist hierbei erforderlich.
Anschließend muss Homeassistant neu gestartet werden.
Wenn das Icon vom HACS Menüentrag fehlt muss der Broser Cache einmal geleert werden.


# Manuell eingerichtete Integrationen / Geräte 


## Sonne 

Nach Installation automatisch vorhanden

* Integration: Sonne 
* Umbenennen in: Sun
* Alle Entitäten aktivieren


## Wetter 

Nach Installation automatisch vorhanden

* Integration: Forecast von Met.no 
* Name: Home
* Breitengrad, Längengrad, Höhe: <aus configuration.yaml>


## MQTT Broker

* Integration: MQTT 
* Server: Feste IP des MQTT Brokers
* Port: 1883
* Benutzername: Leer 
* Passswort: Leer 
* Umbenennen in: MQTTBroker


## Pushover 

* Integration: Pushover
* Name: Pushover
* API-Key: <Pushover API Key> 
* Benutzer-Token: <Pushover User Token>

## Anwesenheitserkennung (Handy)

* Integration: Ping (ICMP) 
* Host: Feste IP des Gerätes
* Port: 80 
* Umbenennen in: HandyPrivat


## Nous A1T WiFi Smart Socket with Tasmota

* https://nous.technology/product/a1t.html
* https://templates.blakadder.com/nous_A1T.html
* https://www.amazon.de/dp/B0054PSI46?psc=1&ref=ppx_yo2ov_dt_b_product_details

* Configure Wifi on Device 
* Configure Other: Set Device Name and Friendly Name 
* Configure MQTT Broker 
  * Device ist automatically detected in Homeassistant 


## Zigbee / ZHA

Zigbee geräte werde über einen HomeAssistant SkyConnect stick angebunden und über Zigbee2MQTT verwaltet.
Der Stick ist in den Container als Device /dev/ttyNabuCasaSkyConnect gemountet, dieses device wird in den Homeassistant Container weitergegeben. 

ZHA Einrichtung:
* Radio Type: ezsp
* Device: /dev/ttyNabuCasaSkyConnect
* Baudrate: 115200

Weitere Infos:
* Detailinfos USB in LXC mounten: https://gist.github.com/crundberg/a77b22de856e92a7e14c81f40e7a74bd?permalink_comment_id=4524937
* Firmware Updates manuell im Browser: https://connectzbt1.home-assistant.io/firmware-update/


## Homematic 

* In HACS (s. oben) muss zuerst das folgende Repository hinzugefügt werden: 
  * https://github.com/danielperna84/custom_homematic
  * Kategorie: Integrationen
* Anschließend ist die Integration "Homematic(IP) Local" verfügbar und kann heruntergeladen werden
* Der Benutzer Admin in der CCU2 muss ein Paswort gesetzt haben
* In der Firewall Konfiguration der CCU2 muss die IP des Homeassistant-Servers explizit freigegeben werden
* Solange das Webinterface er CUU2 geöffnet ist, sind keine Verbindungen von Homeassistant möglich

* Seite 1:
  * Integration: Homematic(IP) Local
  * Instanzname: HomematicCCU2
  * Host: Feste IP der CCU2
  * Benutzername: Admin
  * Passwort: *****
  * TLS: Nein
  * TLS: Überprüfen: Nein
  * Callback Host: IP Des Docker-Hosts 
  * Callback Port: 12001 
  * JSON-RPC Port: 80
  * Aktiver Sysvar Scan: Ja
  * Sysvar Scan Interval: 30
  * Aktive Systembanachrichtigungen: Ja

* Seite 2:
  * Aktiviere Homematic IP: Nein
  * HmIP-RF Port: 2010
  * Aktiviere Homematic (Bidcos-RF): Ja
  * HM-RF Port: 2001
  * Aktiviere Heizgruppen: Nein
  * Gruppen Port: 9292
  * Gruppen-Plan: /groups
  * Aktiviere Homematic-Wired (Bidcos-Wired): Nein
  * BidCos-Wired Port: 2000


## RF433 Schaltsteckdosen 

Die RF433 Schaltsteckdosen werden über den OpenMQTTGateway (https://docs.openmqttgateway.com) angesteuert.
Zum Schalten muss ein Post in das entsprechende MQTT Topic erfolgen.

Der OpenMQTTGateway ist folgendermaßen konfiguriert:
* Firmware Image: esp32dev-rf
* Gateway Name: OpenMQTTGatewayRF433
* MQTT Base Topic: home/
* Gateway Passwort: <gesetzt>
* Web UI Display Metric: Ja
* Web UI Secure Web UI: Ja
* Logging: Notice
* RF Frequency: 433.920
* RF Library: RF

Das webinterface kann aufgerufen werden über:
* http://admin:<Gateway Passwort>@<feste ip> 

Das Gerät wird in Homeassistant nicht korrekt empfangen und produziert viele Fehler im Log. 
Autodiscovery deaktivieren:
```
mosquitto_pub -t 'home/OpenMQTTGatewayRF433/commands/MQTTtoSYS/config' -m '{"disc":false}'
```


Vom OpenMQTTGateway empfangene Daten können in dem Topic "home/OpenMQTTGatewayRF433/433toMQTT" ausgelesen werden. 

Um einen Schater zu setzen muss ein MQTT Command gesendet werden.
Von den ausgelesenen Werten sind lediglich die Eigenschaften "value, protocol, length , delay" relevant. 
Für das ein und ausschalten ändert sich hierbei lediglich der Wert "value". 
Die Werte "protocol, length , delay" sind bei einem Hersteller immer gleich. 

Beispiel für das Gerät mit dem Intertechno-Einstellungscode "11010 C":
```
# Code für An: "283729"
mosquitto_pub -t 'home/OpenMQTTGatewayRF433/commands/MQTTto433' -m '{"value":283729,"protocol":1,"length":24,"delay":315}'

# Code für Aus: "283732"
mosquitto_pub -t 'home/OpenMQTTGatewayRF433/commands/MQTTto433' -m '{"value":283732,"protocol":1,"length":24,"delay":315}'
```


## Shelly Pro3EM Power Meter 

* Integration: Shelly 
* Host: Feste IP des Gerätes
* Port: 80 
* Umbenennen in: ShellyPro3EM


## Sony-TV

Fernsteuerung muss in den Einstellungen > Netzwerk aktiviert sein.
Das Gerät muss bei der Einrichtung eingeschaltet sein. 

* Integration: Sony Bravia TV
* Host: Feste IP des Gerätes
* PSK verwenden: Nein
* Pin Code: Wird auf dem Geät angezeigt 
* Umbenennen in: TV-Wohnzimmer
