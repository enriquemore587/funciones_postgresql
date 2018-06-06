CREATE OR REPLACE FUNCTION cw.reset_score_bank(IN in_bank_id INTEGER, OUT status INTEGER)
AS $$
BEGIN
	TRUNCATE cw.score_bank;

	INSERT INTO cw.score_bank
	SELECT *, in_bank_id FROM cw.score_buro;
	status = 0;
	--EXCEPTION WHEN OTHERS THEN
	--EXCEPTION BY SQL ERROR
	--status = 1200;
END;
$$ LANGUAGE 'plpgsql';

SELECT cw.reset_score_bank(5);