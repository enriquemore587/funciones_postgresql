
CREATE
OR REPLACE FUNCTION cw.set_a_score_bank (
	IN in_id_score INTEGER,
	IN in_id_bank INTEGER,
	IN in_rango VARCHAR,
	IN in_plazo INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
IF NOT EXISTS ( SELECT 1 FROM cw.banks AS b WHERE b. ID = in_id_bank ) THEN
	status = 1100 ;
ELSE

	UPDATE cw.score_bank SET deadline = in_plazo, "range" = in_rango
	WHERE "id" = in_id_score;
	status = 0;

END IF ; 

--EXCEPTION WHEN OTHERS THEN
--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.set_a_score_bank ( 19, 5, '300-600', 20);