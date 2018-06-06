CREATE OR REPLACE FUNCTION cw.getReferencias(IN in_user_id VARCHAR)
RETURNS TABLE (
	id INTEGER,
	name VARCHAR,
	phone_number VARCHAR,
	phone_number_mobile VARCHAR,
	is_familiar BOOLEAN
) AS $$ 
BEGIN
	RETURN QUERY
	SELECT rud.id::INTEGER, rud.name, rud.phone_number, rud.phone_number_mobile, rud.is_familiar
	FROM cw.references_user_data as rud
	WHERE user_id = in_user_id::uuid;
END;
$$
LANGUAGE plpgsql;


SELECT cw.getReferencias('41343e72-a624-4850-aed1-515395f12cec');