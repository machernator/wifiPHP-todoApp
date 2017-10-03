<?php
require_once 'inc/init.inc.php';
?><!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>MySQL Einstieg</title>
    <link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">
    <link rel="stylesheet" href="css/todo.css">
    <style>
    body {
        padding: 1em;
    }
    </style>
</head>
<body>
    <h1>Todo Liste aus MySQL</h1>
    <?php
    $sql = 'SELECT text, active, datum, name, todos_id FROM todos, user where todos.user_id = user.user_id';

    // Result Set aus $sql ermitteln
    $res = mysqli_query($mysql, $sql);

    // Unser Resultat liefert mindestens eine Zeile
    if ( mysqli_num_rows($res) > 0 ) {
        echo '<table class="pure-table pure-table-bordered">';
        echo '<tr><thead>';

        // automatische Auslesen der Tabellenköpfe
        for($i = 0; $i < mysqli_num_fields($res); $i++) {
            $field_info = mysqli_fetch_field($res);
            echo "<th>{$field_info->name}</th>";
        }

        // Edit Spalte
        echo '<th>edit</th>';

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
            echo '<tr>';
            /*  Alternativ:
                echo '<td>' . $row['todos_id'] . '</td>';
                echo '<td>' . $row['user_id'] . '</td>';
                echo '<td>' . $row['datum'] . '</td>';
                echo '<td>' . $row['text'] . '</td>';
                echo '<td>' . $row['active'] . '</td>';
            */
            foreach ($row as $value) {
                echo '<td>' . $value . '</td>';
            }

            $link = 'todo-update.php?tid=' . $row['todos_id'];

            echo "<td><a href=\"$link\">edit</a></td>";

            echo '</tr>';
        }
        echo '</table>';
    }
    ?>
    <!-- <button class="info">i<p class="info-text">Ein wenig Information</p></button> -->
</body>
</html>