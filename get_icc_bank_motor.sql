
CREATE
OR REPLACE FUNCTION cw.get_icc_bank_motor(IN in_bank INTEGER, IN in_icc INTEGER) RETURNS TABLE (
	id INTEGER,
	icc INTEGER,
	free FLOAT
) AS $$
BEGIN
	RETURN QUERY 
	SELECT icb.id:: INTEGER, icb.icc:: INTEGER, icb.free::FLOAT from cw.icc_bank AS icb
	WHERE icb.bank_id = in_bank AND icb.icc = in_icc  ORDER BY icb.icc ASC;
END ;
$$ LANGUAGE plpgsql;

SELECT
	cw.get_icc_bank_motor(5, 6);