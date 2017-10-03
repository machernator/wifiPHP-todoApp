<?php
/*
    Plaintext Zugangsdaten sollten immer außerhalb der Webroot (hier www)
    gespeichert werden. Dh. wir haben  app-config/app-config.inc.php im
    wamp64 Verzeichnis gespeichert. Auf diesen Ordner kann per HTTP nicht
    zugegriffen werden.

    Inhalt der app-config.inc.php

    $appConfig = [
        'dbUser' => 'user',
        'dbPassword' => 'password',
        'dbHost' => 'host',
        'dbDatabase' => 'database'
    ];
*/
require_once '../../app-config/app-config.inc.php';

// Zur Datenbank verbinden
$mysql = mysqli_connect(
    $appConfig['dbHost'],
    $appConfig['dbUser'],
    $appConfig['dbPassword'],
    $appConfig['dbDatabase']
);

if (mysqli_connect_error() !== NULL) {
    // Bricht das Script ab und gibt davor noch angegebene Meldung aus.
    die('MySQL Verbindungsfehler: ' . mysqli_connect_error());
}
mysqli_set_charset($mysql, 'utf-8');