CREATE OR REPLACE FUNCTION cw.get_id_municipality_by_id (
	IN in_name VARCHAR,
	OUT exit INTEGER
) AS $$
BEGIN
	SELECT id::INTEGER INTO exit FROM cw.municipalities
	WHERE descripcion = in_name;
END;
$$
LANGUAGE 'plpgsql';


SELECT cw.get_id_municipality_by_id('Ostuacán');