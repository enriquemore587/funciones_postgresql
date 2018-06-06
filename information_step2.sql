/*
	status(1100)	=>	NO EXISTE USUARIO
	status(1200)	=>	ERROR SQL
	status(0)			=>	SUCCESS
*/
CREATE OR REPLACE FUNCTION information_step2
(
IN in_id VARCHAR,
IN in_state INTEGER,
IN in_municipality INTEGER,
IN in_colony	VARCHAR,
IN in_street	VARCHAR,
IN in_ext 	VARCHAR,
IN in_int	VARCHAR,
IN in_cp	VARCHAR,
IN in_additional_reference	VARCHAR,
IN in_years_residence INTEGER,
IN in_country	VARCHAR,
OUT status INTEGER
)
 AS $$
	BEGIN
	IF NOT EXISTS (SELECT 1 FROM cw.users AS u WHERE u.id = in_id::uuid) THEN
	--	no existe usuario
	status = 1100;
	ELSE
		--	usuario existe
		IF EXISTS (SELECT 1 FROM cw.user_address AS u where u.id = in_id::uuid)	THEN
			--	usuario actualiza su informacion etapa 2
			UPDATE cw.user_address 
					SET state = in_state, municipality = in_municipality,
					colony = in_colony, street = in_street, ext = in_ext, int = in_int,
					cp = in_cp, additional_reference = in_additional_reference, years_residence = in_years_residence,
					country = in_country WHERE id = in_id::uuid;
			status = 0;
		ELSE
			--	usuario registra su informacion etapa 2
			INSERT INTO cw.user_address
			(id, state, municipality, colony, street, ext, int, cp, additional_reference, years_residence, country)
			VALUES
			(in_id::uuid, in_state, in_municipality, in_colony, in_street, in_ext, in_int, in_cp, in_additional_reference, in_years_residence, in_country);
			status = 0;	
		END IF;
	END if;

EXCEPTION WHEN OTHERS THEN
	-- EXCEPTION BY SQL ERROR
	status = 1200;

END;
$$ LANGUAGE 'plpgsql'