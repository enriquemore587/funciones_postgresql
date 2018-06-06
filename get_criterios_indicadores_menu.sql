CREATE
OR REPLACE FUNCTION cw.get_criterios_indicadores_menu (IN in_id_bank INTEGER, IN in_category_id INTEGER, IN in_product_id INTEGER) RETURNS TABLE (
	id INTEGER,
	name VARCHAR,
	range  VARCHAR,
	is_ok BOOLEAN,
	var_array VARCHAR,
	status BOOLEAN
) AS $$
BEGIN
	RETURN QUERY 

	SELECT bv.var_fix_id, vf.name, bv."range"::VARCHAR, bv.is_ok, bv.var_array, bv.active as status
	FROM cw.variables_fix AS vf

	INNER JOIN cw.bank_variables as bv ON bv.var_fix_id = vf.id

	WHERE vf.category_id = in_category_id AND bv.bank_id = in_id_bank AND bv.product_id = in_product_id
	ORDER BY bv.var_fix_id ASC;
END ; $$ LANGUAGE plpgsql;



SELECT
	cw.get_criterios_indicadores_menu(5, 1, 1);