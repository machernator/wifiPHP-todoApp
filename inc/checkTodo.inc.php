<?php
$msg = '';
if (count($_GET) > 0 &&
    array_key_exists('doneid', $_GET) &&
    $_GET['doneid'] != '') {
    $doneid = mysqli_escape_string($mysql, $_GET['doneid']);

    // Auf inaktiv (0) setzen

   
}