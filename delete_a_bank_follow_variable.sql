CREATE OR REPLACE FUNCTION cw.delete_a_bank_follow_variable(IN in_bank_id INTEGER, IN in_id_var_fix INTEGER, OUT status INTEGER)
AS $$
DECLARE _id INTEGER;
	BEGIN
			SELECT id INTO _id FROM cw.bank_variables AS bv WHERE bv.bank_id = in_bank_id AND bv.var_fix_id = in_id_var_fix;
			DELETE FROM cw.bank_follow_variables WHERE variable_id = _id;
			status:= 0;
	END;
$$ LANGUAGE 'plpgsql';

SELECT cw.delete_a_bank_follow_variable(5, 4);