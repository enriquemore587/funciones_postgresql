--	SUCCESS => STATUS 0
--	STATUS (1100) => USUARIO NO EXISTE
--	STATUS (1200) => ERROR SQL ID NO VALIDO

CREATE
OR REPLACE FUNCTION cw.information_step1 (
	IN in_id VARCHAR,
	IN in_name VARCHAR,
	IN in_name2 VARCHAR,
	IN in_last_name VARCHAR,
	IN in_last_name2 VARCHAR,
	IN in_birthdate DATE,
	IN in_gender VARCHAR,
	IN in_phone VARCHAR,
	IN in_mobile_phone VARCHAR,
	IN in_rfc VARCHAR,
	IN in_curp VARCHAR,
	IN in_nationality INTEGER,
	IN in_country VARCHAR,
	IN in_american_citizenship CHAR,
	IN in_entity_birth INTEGER,
	IN in_level_study INTEGER,
	IN in_civil_status INTEGER,
	IN in_mobile_phone_company VARCHAR,
	IN IN_folio_ine VARCHAR,
	IN in_clave_electoral VARCHAR,
	IN in_ocupation_id INTEGER,
	OUT status INTEGER
) AS $$
BEGIN

	IF NOT EXISTS (SELECT 1 from cw.users as u WHERE u.id = in_id::uuid) THEN
			status = 1100;
		ELSE
			--	UP = TRUE => ACTUALIZAR && LOS DATOS DEL USUARIO YA EXISTEN
			IF EXISTS (SELECT 1 from cw.user_personal_data as upd WHERE upd.id = in_id::uuid) THEN
				SELECT 0 INTO status;
				UPDATE cw.user_personal_data SET name = in_name, name2 = in_name2, last_name = in_last_name,
					last_name2 = in_last_name2, birthdate = in_birthdate, gender = in_gender, phone = in_phone, mobile_phone = in_mobile_phone, rfc = in_rfc,
					curp = in_curp, nationality = in_nationality, country = in_country, american_citizenship = in_american_citizenship, entity_birth = in_entity_birth,
					level_study = in_level_study, civil_status = in_civil_status, mobile_phone_company = in_mobile_phone_company, folio_ine = IN_folio_ine, clave_electoral = in_clave_electoral,
					ocupations_id = in_ocupation_id
					WHERE id = in_id::uuid;
			--	UP = FALSE =>	ES UN NUEVO REGISTRO 
			ELSIF NOT EXISTS (SELECT 1 from cw.user_personal_data as upd WHERE upd.id = in_id::uuid) THEN
				SELECT 0 INTO status;
				INSERT INTO cw.user_personal_data (
					id,
					NAME,
					name2,
					last_name,
					last_name2,
					birthdate,
					gender,
					phone,
					mobile_phone,
					rfc,
					curp,
					nationality,
					country,
					american_citizenship,
					entity_birth,
					level_study,
					civil_status,
					mobile_phone_company,
					folio_ine,
					clave_electoral,
					ocupations_id
				)
				VALUES
					(
						in_id::uuid,
						in_name,
						in_name2,
						in_last_name,
						in_last_name2,
						in_birthdate,
						in_gender,
						in_phone,
						in_mobile_phone,
						in_rfc,
						in_curp,
						in_nationality,
						in_country,
						in_american_citizenship,
						in_entity_birth,
						in_level_study,
						in_civil_status,
						in_mobile_phone_company,
						IN_folio_ine,
						in_clave_electoral,
						in_ocupation_id
					);
			END IF;
		END IF;
EXCEPTION WHEN OTHERS THEN
	--EXCEPTION BY SQL ERROR
	status = 1200;
END;
$$ LANGUAGE 'plpgsql'
