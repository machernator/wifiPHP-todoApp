<?php
$msg = '';

if (count($_POST) > 0) {
    $todo = '';
    $user = '';
    $categories = [];
    // potentiell könnte $categories auch einen Fehler erzeugen -> 3!
    $errors = 2;
    
    // Validierung
    if (array_key_exists('todo', $_POST) && $_POST['todo'] !== '') {
        $todo = $_POST['todo'];
        $errors--;
    } else {
        $msg .= '<p class="error">Bitte Text für Todo eingeben</p>';
    }
    
    if (array_key_exists('user', $_POST) && $_POST['user'] !== '') {
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
        $sql ="INSERT INTO todos (text, user_id) VALUES ('" .
                mysqli_real_escape_string($mysql, $todo) . "'," .
                mysqli_real_escape_string($mysql, $user) . ")";

        $res = mysqli_query($mysql, $sql);
        
        if ($res === false) {
            $msg = '<p class="error">Todo konnte nicht eingetragen werden.</p>';
        } else {
            // zuletzt erstellte ID aus INSERT/UPDATE ermitteln
            $insertId = mysqli_insert_id($mysql);

            $seperator = '';
            // Categories speichern
            if (count($categories) > 0) {
                $sqlCat = "INSERT INTO todos_categories (todos_id, categories_id) VALUES ";

                foreach ($categories as $value) {
                    $sqlCat .= $seperator . "($insertId, $value)";
                    $seperator = ' ,';
                }
                echo $sqlCat;
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
