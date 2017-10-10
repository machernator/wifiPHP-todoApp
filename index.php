<?php
require_once 'inc/init.inc.php';
require_once 'inc/deleteUser.inc.php';
require_once 'inc/checkTodo.inc.php'
?><!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>MySQL Einstieg</title>
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">
    <link rel="stylesheet" href="css/todo.css">
</head>
<body>
    <p><a href="todo-new.php" class="pure-button pure-button-primary">Neues Todo</a></p>
    <h1>Todo Liste aus MySQL</h1>
    <?= $msg ?>
    <?php
    $sql = 'SELECT text, active, name, todos_id FROM todos, user where todos.user_id = user.user_id ORDER BY active DESC, name';

    // Result Set aus $sql ermitteln
    $res = mysqli_query($mysql, $sql);

    // Unser Resultat liefert mindestens eine Zeile
    if ( $res && mysqli_num_rows($res) > 0 ) {
        echo '<table class="pure-table pure-table-bordered">';
        echo '<tr><thead>';

        // automatische Auslesen der Tabellenköpfe
       /*  for($i = 0; $i < mysqli_num_fields($res); $i++) {
            $field_info = mysqli_fetch_field($res);
            echo "<th>{$field_info->name}</th>";
        } */
        echo "<th>Text</th>";
        echo "<th>User</th>";
        echo "<th>Done</th>";

        // Edit Spalte
        echo '<th>edit</th>';
        echo '<th>delete</th>';

        echo '</thead></tr>';
        /*
            Gib jede Zeile aus, bis wir am Ende des Resultast ($res) angelangt sind.
            mysqli_fetch_assoc bzw. mysqli_fetch_array liefern ein assoziatives bzw.
            ein automatisch numeriertes Array. 

            mysqli_fetch_assoc nimmt den Spaltennamen als Index.
            
            Jeder Eintrag stellt eine Spalte aus
            unserem angeforderten Ergebnis dar. mysqli_fetch liefert beide Arten an
            Arrays, benötigt daher doppelt so viel Speicher.


        */
        while( $row = mysqli_fetch_assoc($res) ) {
            // inaktive markieren
            $style = '';

            if($row['active'] == 0) {
                $style = 'style="text-decoration: line-through"';
            }

            echo "<tr $style>";
            echo '<td>' . $row['text'] . '</td>';
            echo '<td>' . $row['name'] . '</td>';               
           
            /*  Automatisch: 
            foreach ($row as $value) {
                echo '<td>' . $value . '</td>';
            } */

            
            $editLink = 'todo-update.php?tid=' . $row['todos_id'];
            $deleteLink = './?tid=' . $row['todos_id'];
            $doneLink = './?doneid=' . $row['todos_id'];
            
            echo '<td><a href="./' . $doneLink . '">OK</a></td>';
            echo "<td><a href=\"$editLink\">edit</a></td>";
            echo "<td><a href=\"$deleteLink\" class=\"delete\">delete</a></td>";

            echo '</tr>';
        }
        echo '</table>';
    }
    ?>
<script src="js/deleteLinks.js"></script>
</body>
</html>