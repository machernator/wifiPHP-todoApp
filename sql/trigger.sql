DROP TRIGGER backupTodo;/* Falls schon vorhanden */
DELIMITER $$
CREATE TRIGGER backupTodo BEFORE DELETE ON todos
FOR EACH ROW
BEGIN
	INSERT INTO todos_backup (text, user_id) VALUES (OLD.text, OLD.user_id);
END $$
DELIMITER ;