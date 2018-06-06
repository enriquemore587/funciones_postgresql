CREATE OR REPLACE FUNCTION cw.reset_icc_bank(IN in_bank_id INTEGER, OUT status INTEGER)
AS $$
BEGIN
	TRUNCATE cw.icc_bank;

	INSERT INTO cw.icc_bank
	SELECT *, in_bank_id FROM cw.icc_buro;
	status = 0;
	EXCEPTION WHEN OTHERS THEN
	--EXCEPTION BY SQL ERROR
	status = 1200;
END;
$$ LANGUAGE 'plpgsql'

SELECT cw.reset_icc_bank(5);