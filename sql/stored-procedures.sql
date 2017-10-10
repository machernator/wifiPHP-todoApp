DELIMITER %%
CREATE PROCEDURE fetchProducts()
BEGIN
	SELECT * FROM products;
END %%
DELIMITER ;

/* Aufruf der Procedure */
CALL fetchProducts();

/* 
    Wir können in einer SP mysql Variablen befüllen
    über das Schlüsselwort OUT in der Parameterliste kann ein Wert
    befüllt werden. Dieser Wert kann nach Aufruf der SP über selecte
    jederzeit abgefragt werden.
 */
DELIMITER %%
CREATE PROCEDURE nrProducts(OUT nr INT)
BEGIN
	SELECT COUNT(*) INTO nr FROM products;
END %%
DELIMITER ;


