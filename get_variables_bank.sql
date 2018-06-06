CREATE OR REPLACE FUNCTION cw.get_variables_bank (IN in_id_bank INTEGER)
RETURNS TABLE (
	var_fix_id INTEGER,
	range VARCHAR,
	is_ok BOOLEAN,
	var_array VARCHAR,
	product_id INTEGER,
	variables_fix_id INTEGER,
	variables_fix_name VARCHAR,
	category_id INTEGER
) AS $$ 
BEGIN
	RETURN QUERY

	SELECT 
		bv.var_fix_id, bv."range", bv.is_ok, bv.var_array, bv.product_id, vs.id::INTEGER AS variables_fix_id, vs."name" AS variables_fix_name, vs.category_id::INTEGER

		FROM cw.bank_variables AS bv 

		INNER JOIN cw.variables_fix as vs ON bv.var_fix_id = vs."id"

	WHERE bv.bank_id = in_id_bank;
END;
$$
LANGUAGE plpgsql;


SELECT cw.get_variables_bank(1);