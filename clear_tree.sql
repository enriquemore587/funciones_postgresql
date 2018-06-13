CREATE
OR REPLACE FUNCTION cw.clear_tree (
	IN in_bank_id INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	DELETE FROM cw.bank_follow_variables WHERE bank_id = in_bank_id AND personal_variable_id IS NOT NULL;
	UPDATE cw.bank_custom_variables SET salida = 0 WHERE bank_id = in_bank_id;
	status = 0;
END;
$$ LANGUAGE 'plpgsql';


SELECT cw.clear_tree(6);
