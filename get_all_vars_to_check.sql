CREATE
OR REPLACE FUNCTION cw.get_all_vars_to_check(IN in_category_id INTEGER) RETURNS TABLE (
	id INTEGER,
	name VARCHAR,
	status boolean
) AS $$
BEGIN
	RETURN QUERY SELECT
			vf."id"::INTEGER,
			vf."name"::VARCHAR,
			FALSE as status
		FROM
			cw.variables_fix AS vf
		WHERE
			vf.category_id = in_category_id
		ORDER BY
			ID ASC;
		END ; 
$$ LANGUAGE plpgsql;


--	1 =>	INDICADORES DE BURO
--	2 =>	PERFIL DE CLIENTE

SELECT
	cw.get_all_vars_to_check(2);