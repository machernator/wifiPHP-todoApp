/* 
    Many to many relation als SQL Statement incl. ALIAS ( AS )

    Wird ein ALIAS im statement definiert, muss dieses überall verwendet 
    werden, ansonsten erzeugen wir einen Fehler

    Der erste INNER JOIN (todos -> todos_categories) ermittelt die Verknüpfung mit der Lookup Table
    Der zweite INNER JOIN (categories -> todos_categories) ermittelt die Verknüpfung mit
    dem Resultat des vorangehenden JOINs
*/
SELECT t.text, c.name FROM todos AS t 
INNER JOIN todos_categories AS tc ON t.todos_id = tc.todos_id 
INNER JOIN categories AS c ON c.categories_id = tc.categories_id