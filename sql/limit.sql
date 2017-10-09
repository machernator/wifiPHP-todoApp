/* 
    LIMIT schränkt die Anzahl der Datensätze in einem Result ein.
    Wir nur eine Zahl angegeben, werden so viele Datensätze ab dem ersten
    gefundenen zurück gegeben. Die Sortierung geschieht immer vor LIMIT

    Werden zwei Zahlen angegeben, bestimmt die erste Zahl den offset, die zweite 
    die Anzhal der zurückgegebenen Daten.
*/
SELECT user.name, todos.text FROM `todos` RIGHT JOIN `user` ON todos.user_id = user.user_id ORDER BY user.name LIMIT 2

SELECT user.name, todos.text FROM `todos` RIGHT JOIN `user` ON todos.user_id = user.user_id ORDER BY user.name LIMIT 2, 2