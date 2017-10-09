/* 
    CROSS JOIN
    Jedes Todo Resultat wird mit jedem User verknüpft - kartesianisches Produkt
    Wahrscheinlich die seltenste Form des selektierens.
*/
SELECT todos.text, user.name FROM `todos`, `user`

SELECT todos.text, user.name FROM `todos`
CROSS JOIN user

/*
    WHERE Syntax ohne JOIN
    Wir schränken das Resultat ein.
    Wir selektieren nur die Einträge, für die eine entsprechende user_id vorhanden ist.
*/
SELECT todos.text, user.name FROM `todos`, `user` 
WHERE todos.user_id = user.user_id

/* 
    JOIN verknüpft Tabellen miteinander. Der einfachste JOIN ist NATURAL JOIN.
    Setzt voraus, dass der selbe Spaltenname in beiden Tabellen vorkommt.
    Das Ergebnis ist das selbe wie bei der vorigen Abfrage.
    Im Result wird die verknüpfende Spalte nur einmal ausgegeben
 */
SELECT todos.text, user.name FROM `todos` 
NATURAL JOIN `user`

/* 
    Liefert das selbe Ergebnis wie WHERE ohne JOIN, diesmal aber semantisch korrekt.
    Es werden nur Ergebnisse geliefert, bei denen die user_id in beiden Datensätzen
    vorhanden ist.
*/
SELECT todos.text, user.name FROM `todos` 
INNER JOIN `user` ON todos.user_id = user.user_id

/* 
    LEFT JOIN
    Es werden alle Einträge aus der linken Tabelle und die Schnittmenge mit der rechten 
    Tabelle geliefert.

    Anders gesagt: Es werden alle Einträge aus todos geliefert, hat der Eintrag keine Entsprechung in user, wird im Ergebnis bei user.name NULL ausgegeben.
*/
SELECT todos.text, user.name FROM `todos` 
LEFT JOIN `user` ON todos.user_id = user.user_id

/* 
    Es werden alle Einträge aus der rechten Tabelle und die Schnittmenge mit der linken 
    Tabelle geliefert.

    Anders gesagt: Es werden alle Einträge aus user geliefert, hat der Eintrag keine Entsprechung in todos, wird im Ergebnis bei todos.text NULL ausgegeben.
*/
SELECT todos.text, user.name FROM `todos` 
RIGHT JOIN `user` ON todos.user_id = user.user_id
ORDER BY user.name
