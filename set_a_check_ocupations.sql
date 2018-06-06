CREATE OR REPLACE FUNCTION cw.set_a_check_ocupations_nationalites (
	IN in_id_bank INTEGER,
	IN in_value VARCHAR,
	IN in_id_var_fix INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
	IF NOT EXISTS ( SELECT 1 FROM cw.banks AS b WHERE b. ID = in_id_bank ) THEN
		status = 1100 ;
	ELSE
		UPDATE cw.bank_variables SET var_array = in_value WHERE bank_id = in_id_bank AND var_fix_id = in_id_var_fix;
		status = 0;
	END IF ; 
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.set_a_check_ocupations_nationalites ( 5, '1-6-5', 8);