
CREATE OR REPLACE FUNCTION cw.set_user_credit_request(
	IN in_user_id VARCHAR,
	IN in_bank_id INTEGER,
	IN in_requested_amount FLOAT,
	IN in_monthly_payment FLOAT,
	IN in_ingreso_declarado FLOAT,
	IN in_plazo_solicitado FLOAT,
	OUT status INTEGER,
	OUT data_user json
) AS $$
DECLARE
    user_row cw.user_personal_data%ROWTYPE;
DECLARE temp_text TEXT;
BEGIN
	
	INSERT INTO cw.user_credit_request (
	user_id,
	bank_id,
	requested_amount,
	monthly_payment,
	request_date,
	ingreso_declarado,
	plazo_solicitado
	)
	VALUES
	(
	in_user_id::uuid,
	in_bank_id,
	in_requested_amount,
	in_monthly_payment,
	now(),
	in_ingreso_declarado,
	in_plazo_solicitado
	);
	status := 0;
	
	SELECT * INTO user_row FROM cw.user_personal_data AS upd WHERE upd."id" = in_user_id::uuid;
	SELECT '{"gender": 1}'::json into data_user;
	SELECT '{"gender": "'||user_row.gender::TEXT||'", "nationality": "'||user_row.nationality::TEXT||'", "birthdate": "'||user_row.birthdate::TEXT||'", "civil_status" : "'||user_row.civil_status::TEXT||'", "ocupation_id":'||user_row.ocupations_id ||'}' into temp_text;
	SELECT temp_text::json INTO data_user;

END;
$$ LANGUAGE 'plpgsql';


SELECT cw.set_user_credit_request('2be57054-1ab1-4aab-a442-665592700037', 5, 25000, 26000, 500.5, 550.5);