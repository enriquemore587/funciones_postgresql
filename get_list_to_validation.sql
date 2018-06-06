CREATE OR REPLACE FUNCTION cw.get_list_to_validation(IN in_bank_id INTEGER) RETURNS TABLE (
	short INTEGER,	-- id de la tabla follow
	id INTEGER,	--	id de la variable en su tabla original
	name VARCHAR,	--	nombre de la variable
	cat BOOLEAN,
	rango VARCHAR,
	is_ok BOOLEAN,
	var_array VARCHAR,
	id_bank_variables INTEGER,
	expresion VARCHAR
	--exp_restriccion VARCHAR		-- custom_variable => expresion, default_variable => los campos en orden ("range", is_ok, var_array)
)AS $$
BEGIN
	RETURN QUERY
	(SELECT 
		bfv.short::INTEGER,
		bfv.personal_variable_id as variable_id, 		--id	
		bcv.nombre AS name, 												--name
		true AS cat,																--cat
		'VARIABLE NO PERTENECIENTE',								--rango
		null, 																			--is_ok
		'VARIABLE NO PERTENECIENTE', 								--var_array
		0,																					--id_bank_variables
		bcv.expression 															--expresion
	FROM cw.bank_follow_variables AS bfv
	INNER JOIN cw.bank_custom_variables AS bcv ON bcv.id = bfv.personal_variable_id
	WHERE bfv.bank_id = in_bank_id
	UNION
	SELECT 

	bfv.short::INTEGER, 
	bv.var_fix_id as var_fix_id, 	--id
	vf.name AS name, 									--name
	FALSE AS cat,											--cat
	bv."range", 											--rango
	bv.is_ok, 												--is_ok
	bv.var_array, 										--var_array
	bv.id::INTEGER,										--id_bank_variables
	'VARIABLE NO PERTENECIENTE'				--expresion

	FROM cw.bank_follow_variables AS bfv
	INNER JOIN cw.bank_variables AS bv ON bv.id = bfv.variable_id
	INNER JOIN cw.variables_fix AS vf ON vf.id = bv.var_fix_id
	WHERE bfv.bank_id = in_bank_id) ORDER BY short ASC;


END;
$$
LANGUAGE 'plpgsql';

SELECT cw.get_list_to_validation(5);