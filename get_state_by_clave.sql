--	id_state (1100) => USUARIO NO EXISTE
CREATE
OR REPLACE FUNCTION cw.get_state_by_clave(
	IN in_clave VARCHAR,
	OUT name_state VARCHAR,
	OUT id_state INTEGER
) AS $$
BEGIN
	
	SELECT s.id::INTEGER, descripcion INTO id_state, name_state FROM cw.states as s WHERE s.code_curp = in_clave;
	
EXCEPTION WHEN OTHERS THEN
	--EXCEPTION BY SQL ERROR
	id_state = 1200;
END;
$$ LANGUAGE 'plpgsql'

SELECT cw.get_state_by_clave('DF');