
CREATE
OR REPLACE FUNCTION cw.get_all_vars_banco(IN in_bank_id INTEGER) RETURNS TABLE (
	var_fix_id INTEGER,
	name VARCHAR,
	rango VARCHAR,
	is_ok BOOLEAN,
	var_array VARCHAR,
	active BOOLEAN,
	id INTEGER
) AS $$
BEGIN
	RETURN QUERY 
	
	SELECT b.var_fix_id, v.name, b."range" as rango, b.is_ok, b.var_array, b.active, b.id::INTEGER FROM cw.bank_variables  as b
	INNER JOIN cw.variables_fix AS v ON v.id = b.var_fix_id
	WHERE b.bank_id = in_bank_id AND v.calc_show is TRUE
	ORDER BY b.var_fix_id;
END;
$$ LANGUAGE plpgsql;

SELECT cw.get_all_vars_banco(5);