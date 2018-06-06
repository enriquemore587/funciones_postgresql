--	SUCCESS => STATUS 0
--	STATUS (1100) => BANK NO EXISTE
--	STATUS (1200) => ERROR SQL ID NO VALIDO
--	Inserta y actualiza datos de esta tabla

SELECT cw.set_variables_bank(2,5, null, true, null, 1);

SELECT cw.set_variables_bank(2,3, null, null, null, 1);

CREATE
OR REPLACE FUNCTION cw.set_variables_bank (
	IN in_id_var_fix INTEGER,
	IN in_id_bank INTEGER,
	IN in_range VARCHAR,
	IN in_is_ok BOOLEAN,
	IN in_ver_array VARCHAR,
	IN in_product_id INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
	IF NOT EXISTS (SELECT 1 from cw.banks as b WHERE b.id = in_id_bank) THEN
			status = 1100;

		ELSE
				
			--	BANCO YA EXISTE. IF => EXISTE RELACION ENTRE BANCO Y VARIABLES
			IF EXISTS (SELECT 1 from cw.bank_variables as bv WHERE bv.bank_id = in_id_bank AND bv.var_fix_id = in_id_var_fix) THEN
				SELECT 0 INTO status;
				--	SE ACTUALIZA REGISTRO
				UPDATE cw.bank_variables SET 
																	range = in_range,
																	is_ok = in_is_ok, 
																	var_array = in_ver_array, 
																	product_id = in_product_id
				WHERE bank_id = in_id_bank AND var_fix_id = in_id_var_fix;

			--	NO EXISTE REGISTRO EN LA TABLA => SE INSERTA UN NUEVO REGISTRO
			ELSIF NOT EXISTS (SELECT 1 from cw.bank_variables as bv WHERE bv.bank_id = in_id_bank AND bv.var_fix_id = in_id_var_fix) THEN
				SELECT 0 INTO status;
				INSERT INTO cw.bank_variables (
					bank_id,
					var_fix_id,
					range,
					is_ok,
					var_array,
					product_id
				)
				VALUES
					(
					in_id_bank,
					in_id_var_fix,
					in_range,
					in_is_ok,
					in_ver_array,
					in_product_id
					);
			END IF;




		END IF;
--EXCEPTION WHEN OTHERS THEN
	--EXCEPTION BY SQL ERROR
	--status = 1200;
END;
$$ LANGUAGE 'plpgsql';
