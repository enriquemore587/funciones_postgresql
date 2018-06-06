CREATE
OR REPLACE FUNCTION cw.delete_a_custom_variable (
	IN in_id INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	DELETE FROM cw.bank_custom_variables WHERE id = in_id;
	status = 0;
END;
$$ LANGUAGE 'plpgsql';

SELECT cw.delete_a_custom_variable(71);
