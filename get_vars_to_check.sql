CREATE
OR REPLACE FUNCTION cw.get_vars_to_check(IN in_id_bank INTEGER, IN in_category_id INTEGER) RETURNS TABLE (
	id INTEGER,
	name VARCHAR,
	status BOOLEAN
) AS $$
BEGIN
	RETURN QUERY SELECT
		vf."id"::INTEGER as id,
		vf."name"::VARCHAR as name,
		TRUE AS status
	FROM
		cw.bank_variables AS bv
	INNER JOIN cw.variables_fix AS vf ON vf."id" = bv.var_fix_id
	WHERE
		bv.bank_id = in_id_bank
	AND vf.category_id = in_category_id
	AND bv.active = true;
END ; $$ LANGUAGE plpgsql;


--	1 =>	INDICADORES DE BURO
--	2 =>	PERFIL DE CLIENTE

SELECT
	cw.get_vars_to_check(5, 2);