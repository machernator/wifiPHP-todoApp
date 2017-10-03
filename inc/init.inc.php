<?php
// Applikation wird über Array konfiguriert
$appConfig = [
    'dbUser' => 'root',
    'dbPassword' => '',
    'dbHost' => 'localhost',
    'dbDatabase' => 'todo'
];

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