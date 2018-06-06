--	SUCCESS => STATUS 0
--	STATUS (1100) => USUARIO NO EXISTE
--	STATUS (1200) => ERROR SQL ID NO VALIDO

CREATE
OR REPLACE FUNCTION cw.referencias (
	IN in_id INTEGER,
	IN in_name VARCHAR,
	IN in_phone_number VARCHAR,
	IN in_phone_number_mobile VARCHAR,
	IN in_is_familiar BOOLEAN,
	IN in_user_id VARCHAR,
	OUT status INTEGER
) AS $$
BEGIN

	IF NOT EXISTS (SELECT 1 from cw.users as u WHERE u.id = in_user_id::uuid) THEN
			status = 1100;
		ELSE
			IF (0 != in_id) THEN
				UPDATE cw.references_user_data SET name = in_name, phone_number = in_phone_number, phone_number_mobile = in_phone_number_mobile,
					is_familiar = in_is_familiar
					WHERE id = in_id;
				SELECT 0 INTO status;
			ELSE
				
				INSERT INTO cw.references_user_data (
					name,
					phone_number,
					phone_number_mobile,
					is_familiar,
					user_id
				)
				VALUES
					(
						in_name,
						in_phone_number,
						in_phone_number_mobile,
						in_is_familiar,
						in_user_id::uuid
					);
				SELECT 0 INTO status;
			END IF;
		END IF;
EXCEPTION WHEN OTHERS THEN
	status = 1200;
END;
$$ LANGUAGE 'plpgsql'


SELECT cw.referencias(0, 'JUAN JOSÉ VERGARA BAUTISTA', '0000000000', '87954654', TRUE, '41343e72-a624-4850-aed1-515395f12cec');
