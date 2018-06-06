CREATE
OR REPLACE FUNCTION cw.get_score_bank(IN in_bank INTEGER) RETURNS TABLE (
	id INTEGER,
	rango VARCHAR,
	plazo INTEGER
) AS $$
BEGIN
	RETURN QUERY 
	SELECT sb.id::INTEGER, sb.range as rango, sb.deadline::INTEGER as plazo FROM cw.score_bank as sb
	WHERE sb.bank_id = in_bank ORDER BY sb.deadline ASC;
END ;
$$ LANGUAGE plpgsql;

SELECT
	cw.get_score_bank(5);