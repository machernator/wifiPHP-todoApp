<?php
require_once 'inc/init.inc.php';
require_once 'inc/addUser.inc.php';
?>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>New Todo</title>
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">
    <link rel="stylesheet" href="css/todo.css">
</head>
<body>
    <h1>Neues Todo anlegen</h1>
    <?= $msg ?>
    <form action="" method="post" class="pure-form pure-form-stacked" accept-charset="utf-8">
        <label for="todo">Neues Todo</label>
        <input type="text" name="todo" id="todo">
        <?php
            // Alle User selektieren
            $sql = "SELECT user_id, name FROM user ORDER BY name";
            
            // Result Set aus $sql ermitteln
            $res = mysqli_query($mysql, $sql);
            
            if ( $res !== false && mysqli_num_rows($res) > 0 ) {
                // Select box ausgeben
                echo '<label for="user">Zuteilen an:</label>';
                echo '<select name="user" id="user">';
                while( $row = mysqli_fetch_assoc($res) ) {
                    echo '<option value="' . 
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
        <p>Kategorien</p>
        <?php
            // Checkboxen mit Kategorien ausgeben
            $sqlCat = "SELECT * FROM categories ORDER BY name";
            
            // Result Set aus $sql ermitteln
            $resCat = mysqli_query($mysql, $sqlCat);
            
            if ( $resCat !== false && mysqli_num_rows($resCat) > 0 ) {
                while( $row = mysqli_fetch_assoc($resCat) ) {
                    echo '<label>' .
                         '<input type="checkbox" name="categories[]" value="' .
                         $row['categories_id']  .
                         '">' . 
                         $row['name']  .
                         '</label>';
                }
            }
            else {
                echo '<p class="msg">Es gibt keine Kategorien in der DB.</p>';
            }
        ?>
        <input type="submit" value="Senden" class="pure-button pure-button-primary">
    </form>
        <pre>	
        <?php var_dump($_POST); ?>
        </pre>
</body>
</html>