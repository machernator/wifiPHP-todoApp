<?php
$msg = '';
if (count($_GET) > 0 &&
    array_key_exists('tid', $_GET) &&
    $_GET['tid'] != '') {
    $tid = mysqli_escape_string($mysql, $_GET['tid']);

    // Todo löschen
    $sqlDelete = "DELETE FROM todos WHERE todos_id=$tid";
    $resDelete = mysqli_query($mysql, $sqlDelete);
    
    // Verknüpfte Kategorien löschen
    $resDelCat = false;
    if ($resDelete){
        $sqlDelCat = "DELETE FROM todos_categories WHERE todos_id=$tid";
        $resDelCat = mysqli_query($mysql, $sqlDelCat);
    }

    if ($resDelCat) {
        $msg = '<p class="success">Todo erfolgreich gelöscht</p>';
    }
    else {
        $msg = '<p class="success">Todo konnte nicht gelöscht werden.</p>';
    }
}