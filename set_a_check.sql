
CREATE
OR REPLACE FUNCTION cw.set_a_check (
	IN in_id_var_fix INTEGER,
	IN in_id_bank INTEGER,
	IN in_active BOOLEAN,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
IF NOT EXISTS ( SELECT 1 FROM cw.banks AS b WHERE b. ID = in_id_bank ) THEN
	status = 1100 ;
ELSE
/*	
		IF in_active = FALSE THEN
			SELECT INTO status cw.delete_a_bank_follow_variable(in_id_bank, in_id_var_fix);
		END IF;
*/
-----
				IF NOT EXISTS (SELECT 1 from cw.icc_bank WHERE bank_id = in_id_bank) THEN
					select * INTO status from cw.new_icc_for_bank(in_id_bank::INTEGER);
				END IF;
				IF NOT EXISTS (SELECT 1 from cw.score_bank WHERE bank_id = in_id_bank) THEN
					select * INTO status from cw.new_score_for_bank(in_id_bank::INTEGER);
				END IF;
-----
	IF EXISTS ( SELECT 1 FROM cw.bank_variables AS bv WHERE bv.bank_id = in_id_bank AND bv.var_fix_id = in_id_var_fix ) THEN
			
	UPDATE cw.bank_variables SET active = in_active
	WHERE bank_id = in_id_bank AND var_fix_id = in_id_var_fix;

	--	NO EXISTE REGISTRO EN LA TABLA => SE INSERTA UN NUEVO REGISTRO
	ELSIF NOT EXISTS ( SELECT 1 FROM cw.bank_variables AS bv WHERE bv.bank_id = in_id_bank AND bv.var_fix_id = in_id_var_fix ) THEN

		INSERT INTO cw.bank_variables ( bank_id, var_fix_id, active )
		VALUES ( in_id_bank, in_id_var_fix, in_active );

	END IF ;

	status = 0;
END IF ; 

--EXCEPTION WHEN OTHERS THEN
--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.set_a_check ( 4, 5, TRUE);