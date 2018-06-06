CREATE
OR REPLACE FUNCTION cw.get_bank_follow_variables_by_bank(IN in_bank_id INTEGER) RETURNS TABLE (
	short INTEGER,	-- id de la tabla follow
	id INTEGER,	--	id de la variable en su tabla original
	name VARCHAR,	--	nombre de la variable
	cat BOOLEAN,		--	lo utilizo como flag en el front para saber a donde pertenecen
	var_fix_id INTEGER,
	rango  VARCHAR,
	is_ok BOOLEAN,
	var_array VARCHAR,
	status_variable BOOLEAN,
	salida INTEGER
)AS $$
BEGIN
	RETURN QUERY
	(SELECT bfv.short::INTEGER, bfv.personal_variable_id as variable_id, bcv.nombre AS name, true AS cat, 0 AS var_fix_id, 
	bcv.expression as rango, null as is_ok, NULL as var_array, NULL as status_variable, bcv.salida as salida
	FROM cw.bank_follow_variables AS bfv
	INNER JOIN cw.bank_custom_variables AS bcv ON bcv.id = bfv.personal_variable_id
	WHERE bfv.bank_id = in_bank_id
	UNION
	SELECT bfv.short::INTEGER, bfv.variable_id as variable_id, vf.name AS name, FALSE AS cat, vf.id AS var_fix_id, 
	bv."range" as rango, bv.is_ok, bv.var_array, bv.active as status_variable, 0 as salida
	FROM cw.bank_follow_variables AS bfv
	INNER JOIN cw.bank_variables AS bv ON bv.id = bfv.variable_id
	INNER JOIN cw.variables_fix AS vf ON vf.id = bv.var_fix_id
	WHERE bfv.bank_id = in_bank_id) ORDER BY short ASC;


END;
$$
LANGUAGE 'plpgsql';

SELECT cw.get_bank_follow_variables_by_bank(5);