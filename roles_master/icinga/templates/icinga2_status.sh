#!/bin/bash
echo -e "GET services\nColumns: host_name description state plugin_output\n" | /bin/nc -U /var/run/icinga2/cmd/livestatus
