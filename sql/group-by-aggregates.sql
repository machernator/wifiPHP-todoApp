/* 
    Alle status Einträge selektieren, es werden alle Zeilen zurückgegeben
*/
SELECT status FROM `orders`

/* 
    Wenn jeder Status nur einmal ermittelt werden soll, lassen wir die Ergebnisse gruppieren
    GROUP BY

    Alternativ zu dem unten angegebenen Statement:
    SELECT DISTINCT status FROM `orders`
    Jeder Wert wird nur einmal in einem Result zurück gegeben
*/
SELECT status FROM `orders`
GROUP BY status

/* 
    GROUP BY in Kombination mit Aggregatsfunktionen wie COUNT, SUM, MAX, MIN, AVG, ...
*/
SELECT status, COUNT(*) AS anzahl FROM `orders`
GROUP BY status

SELECT status, COUNT(*) AS anzahl FROM `orders`
WHERE status = 'Cancelled'
GROUP BY status

/* 
    Summe mit SUM bilden
    USING erlaubt uns, eine verkürzte Version von WHERE order.orderNumber = orderdetails.orderNumber

    GROUP BY mit Aggregatsfunktionen bildet für jeden gefundenen Eintrag in einer Gruppe z. B. die Summe.
*/
SELECT status, SUM(quantityOrdered * priceEach) AS amount
FROM orders
INNER JOIN orderdetails USING (orderNumber)
GROUP BY status

SELECT orderNumber, SUM(quantityOrdered * priceEach) AS amount
FROM orders
INNER JOIN orderdetails USING (orderNumber)
GROUP BY orderNumber

SELECT YEAR(orderDate) AS year,
SUM(quantityOrdered * priceEach) AS total
FROM orders
INNER JOIN orderdetails USING (orderNumber)
WHERE status = 'Shipped'
GROUP BY YEAR(orderDate)

/* 
    HAVING erfüllt eine ähnliche Funktion wie WHERE, bezieht sich allerdings auf die Gruppierung
    
*/
SELECT YEAR(orderDate) AS year,
SUM(quantityOrdered * priceEach) AS total
FROM orders
INNER JOIN orderdetails USING (orderNumber)
WHERE status = 'Shipped'
GROUP BY year
HAVING year > 2003

/* 
    Typischer Fehler: WHERE muss vor GROUP BY angegeben werden
*/
SELECT YEAR(orderDate) AS year,
SUM(quantityOrdered * priceEach) AS total
FROM orders
INNER JOIN orderdetails USING (orderNumber)
GROUP BY year
WHERE status = 'Shipped'
