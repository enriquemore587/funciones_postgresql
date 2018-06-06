CREATE OR REPLACE FUNCTION cw.get_bak_custom_variables(IN in_bank_id INTEGER) RETURNS TABLE (
	id INTEGER,
	expresion VARCHAR,
	name VARCHAR,
	salida INTEGER
) AS $$
BEGIN
	RETURN QUERY 
	SELECT bc.id, bc.expression, bc.nombre, bc.salida FROM cw.bank_custom_variables AS bc
	WHERE bc.bank_id = in_bank_id ORDER BY bc.id;
END ;
$$ LANGUAGE plpgsql;

SELECT
	cw.get_bak_custom_variables(5);