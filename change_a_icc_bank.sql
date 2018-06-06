
CREATE
OR REPLACE FUNCTION cw.change_a_icc_bank (
	IN in_icc INTEGER,
	IN in_id_bank INTEGER,
	IN in_value INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
IF NOT EXISTS ( SELECT 1 FROM cw.banks AS b WHERE b. ID = in_id_bank ) THEN
	status = 1100 ;
ELSE

	UPDATE cw.icc_bank set "free" = in_value WHERE bank_id = in_id_bank AND icc = in_icc;
	status = 0;

END IF ; 

--EXCEPTION WHEN OTHERS THEN
--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.change_a_icc_bank( 5, 5, 963);