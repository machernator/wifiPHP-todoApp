/* 
    LIKE Syntax
    % ist Platzhalter für einen beliebigen Teilstring
    _ ist Platzhalter für ein beliebiges Zeichen
 */
SELECT * FROM employees WHERE firstName LIKE 'ma%'
SELECT * FROM employees WHERE firstName LIKE '%ar%'
SELECT * FROM employees WHERE lastName LIKE 'b%'
SELECT * FROM employees WHERE firstName LIKE 'T_m%'
SELECT * FROM employees WHERE firstName LIKE 'An%y'

/* Escape Sequenzen */
SELECT * FROM products WHERE productCode LIKE '%\_20%'

/* 
    MATCH AGAINST Syntax
 */
SELECT productName, productline
from products
WHERE MATCH(productline) AGAINST ('Classic,Vintage')

SELECT productName, productDescription
from products
WHERE MATCH(productDescription) AGAINST ('features,wheel')
