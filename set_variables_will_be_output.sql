CREATE OR REPLACE FUNCTION cw.set_variables_will_be_output (
	IN in_bank_id INTEGER,	
	IN in_id_mensualidad INTEGER,
	IN in_id_plazo INTEGER,
	IN in_id_linea_credito INTEGER,
	IN in_id_tasa INTEGER,
	OUT status INTEGER
) AS $$
BEGIN

	--	clean data by bank
	UPDATE cw.bank_custom_variables SET salida = 0 WHERE bank_id = in_bank_id;
	-- UPDATE mensualidad
	UPDATE cw.bank_custom_variables SET salida = 1 WHERE bank_id = in_bank_id AND id = in_id_mensualidad;
	-- UPDATE plazp
	UPDATE cw.bank_custom_variables SET salida = 2 WHERE bank_id = in_bank_id AND id = in_id_plazo;
	-- UPDATE linea_credito
	UPDATE cw.bank_custom_variables SET salida = 3 WHERE bank_id = in_bank_id AND id = in_id_linea_credito;
	--	UPDATE tasa
	UPDATE cw.bank_custom_variables SET salida = 4 WHERE bank_id = in_bank_id AND id = in_id_tasa;
	
	status = 0;

END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.set_variables_will_be_output (5, 93, 94, 95, 96);
