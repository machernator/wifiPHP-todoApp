/* 
    User anlegen mit CREATE USER
    http://www.mysqltutorial.org/mysql-grant.aspx
*/
CREATE USER thomas@localhost IDENTIFIED BY '1234'
/* Von überall her verbinden */
CREATE USER thomas@'%' IDENTIFIED BY '1234'
CREATE USER thomas@'%.mydomain.at' IDENTIFIED BY '1234'
CREATE USER thomas@'127.0.0.1' IDENTIFIED BY '1234'

/* User löschen */
DROP USER thomas@localhost


/* 
    Berechtigungen abfragen
*/
SHOW GRANTS FOR thomas@localhost

/* 
    Berechtigungen vergeben mit GRANT Syntax, Alle Berechtigungen vergeben
    Werden Berechtigungen vergeben, schließt das automatisch alle anderen Operationen aus.
    Dh. in unserem Beispiel, dass der User nur selektieren kann, alle anderen Operationen 
    sind nicht erlaubt.
*/
GRANT ALL ON *.* TO thomas@localhost

GRANT SELECT ON classicmodels.* TO thomas@localhost

/* Passwort ändern */
UPDATE user SET authentication_string = PASSWORD('4321')
WHERE user='thomas' AND host='localhost';

/* Lädt den cache, vergewissert, dass das neue Passwort ab jetzt gültig ist */
FLUSH PRIVILEGES;

/* Webuser Beispiel */
CREATE USER 'webuser'@'localhost' IDENTIFIED WITH mysql_native_password AS '***';
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'webuser'@'localhost' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;