
SELECT cw.aakk ('1,2,3', 5, '200-250', TRUE, 'a,b,c', 1 );

SELECT cw.aakk ( '1,2,3', 5, NULL, true, NULL, NULL );

CREATE
OR REPLACE FUNCTION cw.aakk (
	IN in_id_var_fix VARCHAR,
	IN in_id_bank INTEGER,
	IN in_range VARCHAR,
	IN in_is_ok BOOLEAN,
	IN in_ver_array VARCHAR,
	IN in_product_id INTEGER,
	OUT status INTEGER
) AS $$
DECLARE list VARCHAR [];
DECLARE i VARCHAR ;
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
IF NOT EXISTS ( SELECT 1 FROM cw.banks AS b WHERE b. ID = in_id_bank ) THEN
	status = 1100 ;
ELSE
	SELECT regexp_split_to_array(in_id_var_fix, ',') INTO list; 
	i := 1;
	FOREACH i IN ARRAY list LOOP
	IF EXISTS ( SELECT 1 FROM cw.bank_variables AS bv WHERE bv.bank_id = in_id_bank AND bv.var_fix_id = i :: INTEGER ) THEN
		SELECT 0 INTO status ; --	SE ACTUALIZA REGISTRO
			
	UPDATE cw.bank_variables SET RANGE = in_range, is_ok = in_is_ok, var_array = in_ver_array, product_id = in_product_id
	
	WHERE bank_id = in_id_bank AND var_fix_id = i :: INTEGER ;
	--	NO EXISTE REGISTRO EN LA TABLA => SE INSERTA UN NUEVO REGISTRO
	ELSIF NOT EXISTS (
		SELECT
			1
		FROM
			cw.bank_variables AS bv
		WHERE
			bv.bank_id = in_id_bank
		AND bv.var_fix_id = i :: INTEGER
	) THEN
		SELECT
			0 INTO status ; INSERT INTO cw.bank_variables (
				bank_id,
				var_fix_id,
				RANGE,
				is_ok,
				var_array,
				product_id
			)
		VALUES
			(
				in_id_bank,
				i :: INTEGER,
				in_range,
				in_is_ok,
				in_ver_array,
				in_product_id
			) ;
		END
		IF ;
		END LOOP ;
		END
		IF ; --EXCEPTION WHEN OTHERS THEN
		--status = 1200;
		END ; $$ LANGUAGE 'plpgsql'