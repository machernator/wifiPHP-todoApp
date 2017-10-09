<?php
require_once 'inc/init.inc.php';

// todos_id ermitteln
$tid = 0;
if (array_key_exists('tid', $_GET) && $_GET['tid'] !== '') {
    // TODO: auf Ganzzahl prüfen
    $tid = $_GET['tid'];
}
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Update Todo</title>
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">
    <link rel="stylesheet" href="css/todo.css">
</head>
<body>
    <h1>Aktualisieren</h1>
    <?php
    // Datensatz ermitteln
    if ($tid !== 0) {
        $currentUser = 0;
        // Query zusammen setzen
        $sql = "SELECT * FROM todos WHERE todos_id=$tid";
        
        // Result Set aus $sql ermitteln
        $res = mysqli_query($mysql, $sql);

        // Unser Resultat liefert mindestens eine Zeile
        if ( $res !== false && mysqli_num_rows($res) === 1 ) {
            if( $row = mysqli_fetch_assoc($res) ) {
                $currentUser = $row['user_id'];
            ?>
            <form action="" method="post" class="pure-form pure-form-stacked" accept-charset="utf-8">
                <!-- Damit die Id nicht verloren geht, speichern wir sie
                in einem hidden field -->
                <input type="hidden" name="id" id="id" value="<?= $row['todos_id'] ?>">

                <label for="todo">Todo</label>
                <input type="text" name="todo" id="todo" value="<?= $row['text'] ?>">

                <?php
                // Alle User selektieren
                $sqlUser = "SELECT user_id, name FROM user ORDER BY name";
                $sqlCategories = 
                
                // Result Set aus $sqlUser ermitteln
                $resUser = mysqli_query($mysql, $sqlUser);
                
                if ( $resUser !== false && mysqli_num_rows($resUser) > 0 ) {
                    // Select box ausgeben
                    echo '<label for="user">Zuteilen an:</label>';
                    echo '<select name="user" id="user">';
                    while( $row = mysqli_fetch_assoc($resUser) ) {
                        $selected = '';
                        /*
                            Prüfen, ob der aktuelle User mit dem über GET angefragten
                            User übereinstimmt -> selected!
                        */
                        if ($currentUser === $row['user_id']) {
                            $selected = ' selected';
                        }

                        echo '<option' .
                                $selected .
                                ' value="' . 
                                $row['user_id'] . '">' . 
                                $row['name'] . 
                                '</option>';
                    }
                    echo '</select>';
                }
                else {
                    echo '<p class="msg">Es gibt keine User in der DB.</p>';
                }
                ?>

                <p><strong>Kategorien</strong></p>
                <?php
                    // Array mit dem aktuellen Datensatz zugeordneten Categories
                    $myCats = [];

                    $sqlMyCats = "SELECT * FROM todos_categories WHERE todos_id = $tid";

                    $resMyCats = mysqli_query($mysql, $sqlMyCats);

                    if ( $resMyCats !== false && mysqli_num_rows($resMyCats) > 0 ) {
                        // $myCats befüllen
                        while( $row = mysqli_fetch_assoc($resMyCats) ) {
                            $myCats[] = $row['categories_id'];
                        }
                    }

                    // Checkboxen mit Kategorien ausgeben
                    $sqlCat = "SELECT * FROM categories ORDER BY name";
                    
                    // Result Set aus $sql ermitteln
                    $resCat = mysqli_query($mysql, $sqlCat);
                    
                    if ( $resCat !== false && mysqli_num_rows($resCat) > 0 ) {
                        while( $row = mysqli_fetch_assoc($resCat) ) {
                            $checked = '';
                            // Prüfen, ob die aktuelle categories_id in $myCats vorkommt
                            if (in_array($row['categories_id'], $myCats)) {
                                $checked = ' checked';
                            }

                            echo '<label>' .
                                 '<input type="checkbox" name="categories[]" value="' .
                                 $row['categories_id']  .
                                 '"' .
                                 $checked .
                                 '>' . 
                                 $row['name']  .
                                 '</label>';
                        }
                    }
                    else {
                        echo '<p class="msg">Es gibt keine Kategorien in der DB.</p>';
                    }
                ?>
            </form>
            <?php
            }
        }
    }
    else {
        echo '<p>Fehler</p>';
    }

    ?>
</body>
</html>