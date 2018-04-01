
<?php

# Netzwerke für Auto Discover
$config['nets'][] = '10.5.0.0/24';
$config['nets'][] = '192.168.0.0/24';

# Ignorierte Interfaces
$config['bad_if_regexp'][] = '/^lo.*$/';
$config['bad_if_regexp'][] = '/^br.*$/';
$config['bad_if_regexp'][] = '/^pf.*$/';
$config['bad_if_regexp'][] = '/^veth.*$/';
$config['bad_if_regexp'][] = '/^bridge.*$/';
$config['bad_if_regexp'][] = '/^docker.*$/';

?>
