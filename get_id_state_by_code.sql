

CREATE OR REPLACE FUNCTION cw.get_id_state_by_code (
	IN in_code VARCHAR,
	OUT exit INTEGER
) AS $$
BEGIN
	SELECT id::INTEGER INTO exit FROM cw.states
	WHERE code_curp = in_code;
END;
$$
LANGUAGE 'plpgsql';


SELECT cw.get_id_state_by_code('DF');