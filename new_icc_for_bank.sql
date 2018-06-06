
CREATE
OR REPLACE FUNCTION cw.new_icc_for_bank (
	IN in_id_bank INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
INSERT into cw.icc_bank 
(icc, spending, "free", bank_id)
VALUES
		(	4,	75,	25,	in_id_bank),
		(	5,	70,	30,	in_id_bank),
		(	6,	67,	33,	in_id_bank),
		(	7,	65,	35,	in_id_bank),
		(	8,	60,	40,	in_id_bank),
		(	9,	55,	45,	in_id_bank);
status = 0;

--EXCEPTION WHEN OTHERS THEN
--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.new_icc_for_bank(3);