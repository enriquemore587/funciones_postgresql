
CREATE
OR REPLACE FUNCTION cw.set_a_bank_custom_variable (
	IN in_bank_id INTEGER,
	IN in_expression VARCHAR,
	IN in_product_id INTEGER,
	IN in_id INTEGER,
	IN in_nombre VARCHAR,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
	IF NOT EXISTS ( SELECT 1 FROM cw.banks AS b WHERE b. ID = in_bank_id ) THEN
		status = 1100 ;
	ELSE
		--IF NOT EXISTS ( SELECT 1 FROM cw.bank_custom_variables AS bc WHERE bc.id = in_id ) THEN
		IF (in_id = 0) THEN

			INSERT INTO cw.bank_custom_variables (bank_id, expression, product_id, nombre )
			VALUES
			(in_bank_id, in_expression, in_product_id, in_nombre );
			status = 0;

		ELSE
			UPDATE cw.bank_custom_variables SET bank_id = in_bank_id, expression = in_expression, product_id = in_product_id, nombre = in_nombre 
			WHERE id = in_id;
			status = 0;

		END if;

		
	END IF ;
--EXCEPTION WHEN OTHERS THEN
	--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.set_a_bank_custom_variable ( 75, '1+2', 1, 0, 'nombre');