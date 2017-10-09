/* 
    Ein View verhält sich wie eine Tabelle. Wird diese angesprochen,
    wird das zugeordnete SQL Statement ausgeführt.

    Wird ein Select Statement auf einer View ausgeführt, wird die View
    behandelt, als wäre sie eine eigenständige Tabelle.
*/
CREATE VIEW all_todos AS SELECT * FROM todos

CREATE VIEW todos_cats AS 
SELECT t.text, c.name FROM todos AS t 
INNER JOIN todos_categories AS tc ON t.todos_id = tc.todos_id 
INNER JOIN categories AS c ON c.categories_id = tc.categories_id

/* 
    classicmodels
 */
CREATE VIEW customersOrders AS
    SELECT d.orderNumber,
            customerName,
            SUM(quantityOrdered * priceEach) AS total
    FROM
        orderDetails AS d
    INNER JOIN
        orders AS o ON o.orderNumber = d.orderNumber
    INNER JOIN
        customers AS c ON c.customerNumber = o.customerNumber
    GROUP BY d.orderNumber
    ORDER BY total DESC;

/* 
    VIEW mit Subselect
*/
CREATE VIEW aboveAvgProducts AS
    SELECT productCode, productName, buyPrice
    FROM products
    WHERE buyPrice >
    ( SELECT AVG(buyPrice) FROM products )
    ORDER BY buyPrice DESC;