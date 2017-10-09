/* 
    GROUP_CONCAT kann aus gruppierten Werten einen einzelnen String bilden.
    Für jede Zeile Text wird jeder unterschiedliche Wert c.name per GROUP_CONCAT
    zu einem String zusammen geführt
    Die Kategorien werden in einer Zeile ausgegeben.
*/
SELECT t.text, t.active, u.name, GROUP_CONCAT(c.name ORDER BY c.name DESC SEPARATOR ', ') AS catname 
FROM todos as t
/* Lookup Table */
INNER JOIN todos_categories AS tc ON t.todos_id = tc.todos_id
/* Categories name auslesen */
INNER JOIN categories AS c ON tc.categories_id = c.categories_id
/* User Name auslesen, verknüft mit todos! */
INNER JOIN user AS u ON t.user_id = u.user_id
GROUP BY text