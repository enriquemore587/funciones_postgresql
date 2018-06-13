CREATE
OR REPLACE FUNCTION cw.get_user_for_test(IN in_bank_id INTEGER) RETURNS TABLE (
	requested_amount FLOAT,
	monthly_payment FLOAT,
	ingreso_declarado FLOAT,
	plazo_solicitado INTEGER,
	bank_id INTEGER,
	user_id VARCHAR
) AS $$
BEGIN
	RETURN QUERY 
	SELECT ucr.requested_amount::FLOAT, ucr.monthly_payment::FLOAT, ucr.ingreso_declarado::FLOAT, ucr.plazo_solicitado::INTEGER, ucr.bank_id::INTEGER, ucr.user_id::VARCHAR FROM "cw"."user_credit_request" as ucr
	WHERE ucr.bank_id = in_bank_id ORDER BY ucr.request_date DESC LIMIT 1 ;
END ;
$$ LANGUAGE plpgsql;

SELECT
	cw.get_user_for_test(5);