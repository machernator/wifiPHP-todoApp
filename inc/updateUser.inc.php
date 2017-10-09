<?php
$msg = '';

if (count($_POST) > 0) {
    $todo = '';
    $user = '';
    $tid = 0;
    $categories = [];
    $errors = 3; // tid, todo und user
    
    // Validierung
    if (array_key_exists('tid', $_POST) && $_POST['tid'] !== '') {
        $tid = $_POST['tid'];
        $errors--;
    } else {
        $msg .= '<p class="error">Ungültige ID des Todos</p>';
    }

    if (array_key_exists('todo', $_POST) && $_POST['todo'] !== '') {
        $todo = trim( $_POST['todo'] );
        $errors--;
    } else {
        $msg .= '<p class="error">Bitte Text für Todo eingeben</p>';
    }
    
    if (array_key_exists('user', $_POST) && $_POST['user'] !== '') {
        // TODO: prüfen, ob übermittelter user in DB existiert
        $user = $_POST['user'];
        $errors--;
    } else {
        $msg .= '<p class="error">Bitte einen User zuordnen</p>';
    }

    if (array_key_exists('categories', $_POST)) {
        $categories = $_POST['categories'];
    }

    // Formular fehlerfrei
    if ($errors === 0) {
        // Notwendig, um korrekte Zeichen zu garantieren.
        mysqli_set_charset($mysql, 'utf-8');
        
        // Eintrag erstellen, reals escape string für Strings verwenden
        $sql ="UPDATE todos SET text='" .
                mysqli_real_escape_string($mysql, $todo) .
                "', user_id=" .
                mysqli_real_escape_string($mysql, $user) .
                ' WHERE todos_id=' . $tid;

        $res = mysqli_query($mysql, $sql);
        
        if ($res === false) {
            $msg = '<p class="error">Todo konnte nicht aktualisiert werden.</p>';
        } else {
            // Alle bisherigen Verknüpfungen aus todos_categories löschen
            $sqlDelCat = "DELETE FROM todos_categories WHERE todos_id=$tid";
            $resDel = mysqli_query($mysql, $sqlDelCat);

            $seperator = '';
            // Categories speichern
            if ($resDel && count($categories) > 0) {
                $sqlCat = "INSERT INTO todos_categories (todos_id, categories_id) VALUES ";

                foreach ($categories as $value) {
                    $sqlCat .= $seperator . "($tid, $value)";
                    $seperator = ' ,';
                }
                
                if (mysqli_query($mysql, $sqlCat)) {
                    $msg = '<p class="success">Neues Todo erfolgreich angelegt</p>';
                }
                else {
                    $msg = '<p class="success">Neues Todo erfolgreich angelegt. Kategorien sind fehlerhaft.</p>';
                }
            }
        }
    }
}
