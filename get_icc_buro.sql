
CREATE
OR REPLACE FUNCTION cw.get_icc_buro(IN in_icc INTEGER) RETURNS TABLE (
	id INTEGER,
	icc INTEGER,
	free FLOAT
) AS $$
BEGIN
	RETURN QUERY 
	SELECT icb.id:: INTEGER, icb.icc:: INTEGER, icb.free::FLOAT from cw.icc_buro AS icb
	WHERE icb.icc >= in_icc ORDER BY icb.icc ASC;
END ;
$$ LANGUAGE plpgsql;

SELECT
	cw.get_icc_buro(6);