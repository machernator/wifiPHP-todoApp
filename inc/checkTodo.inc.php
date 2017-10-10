<?php
$msg = '';
if (count($_GET) > 0 &&
    array_key_exists('doneid', $_GET) &&
    $_GET['doneid'] != '') {
    $doneid = mysqli_escape_string($mysql, $_GET['doneid']);

    // Auf inaktiv (0) setzen
    $switchSql = "UPDATE todos SET active=0 WHERE todos_id=$doneid";
    $switchRes = mysqli_query($mysql, $switchSql);
    
    if ($switchRes) {
        $msg = '<p class="success">Todo erledigt.</p>';
    }
    else {
        $msg = '<p class="warning">Fehler, todo konnte nicht erledigt werden.</p>';
    }
   
}