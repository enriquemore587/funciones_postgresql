CREATE
OR REPLACE FUNCTION cw.get_order_default_variables_by_bank (IN in_bank_id INTEGER) RETURNS TABLE ("name" VARCHAR, id INTEGER, sort INTEGER, salida INTEGER) AS $$
BEGIN
	RETURN QUERY (
		SELECT

			vf."name",
			bfv.variable_id,
			bfv.short,
			0
		FROM
			cw.bank_follow_variables AS bfv
		INNER JOIN cw.bank_variables AS bv ON bfv.variable_id = bv."id"
		INNER JOIN cw.variables_fix AS vf ON bv.var_fix_id = vf."id"
		WHERE
			bfv.bank_id = in_bank_id
		ORDER BY
			bfv.short ASC
	)
UNION ALL
	(
		SELECT
			bcv.nombre,
			bfv.personal_variable_id,
			bfv.short,
			bcv.salida
		FROM
			cw.bank_follow_variables AS bfv
		INNER JOIN cw.bank_custom_variables AS bcv ON bfv.personal_variable_id = bcv."id"
		WHERE
			bfv.bank_id = in_bank_id
		ORDER BY
			bfv.short ASC
	) ;
END ; $$ LANGUAGE plpgsql;

SELECT
	cw.get_order_default_variables_by_bank (5);