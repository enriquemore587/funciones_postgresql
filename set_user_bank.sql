CREATE
OR REPLACE FUNCTION cw.set_user_bank (
	IN in_bank_id INTEGER,
	IN in_user_id VARCHAR,
	OUT status INTEGER
) AS $$
BEGIN

	UPDATE cw.users
SET id_profile = 4
WHERE
	"id" = in_user_id :: uuid ; 

INSERT INTO cw.users_bank (user_id, bank_id)
VALUES
	(
		in_user_id :: uuid,
		in_bank_id
	) ; 

INSERT INTO cw.bank_variables (bank_id, var_fix_id) SELECT
		in_bank_id,
		ID
	FROM
		cw.variables_fix
	ORDER BY
		sort ASC ; 

UPDATE cw.bank_variables SET "range" = '1-99'  WHERE var_fix_id = 7 AND bank_id = in_bank_id;

INSERT INTO cw.bank_follow_variables (bank_id, variable_id) SELECT
			in_bank_id,
			bv. ID
		FROM
			cw.bank_variables AS bv
		INNER JOIN cw.variables_fix AS vf ON bv.var_fix_id = vf. ID
		WHERE
			bv.bank_id = in_bank_id
		ORDER BY
			vf.sort ; 


status = 0 ;


		END ; 

$$ LANGUAGE 'plpgsql';

SELECT
	cw.set_user_bank (
		7,
		'301eecfb-15da-4b8d-be17-459554ae7ea0'
	);