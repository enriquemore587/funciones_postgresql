
CREATE
OR REPLACE FUNCTION cw.new_score_for_bank (
	IN in_id_bank INTEGER,
	OUT status INTEGER
) AS $$
BEGIN
	--	SE COMPRUEBA QUE EL BANCO EXISTA
INSERT into cw.score_bank 
("range", credit_limit, interest_rate, deadline, bank_id)
VALUES
('501-664',	20000,	36,	24,	in_id_bank),
('0-500',	0,	0,	0,	in_id_bank),
('665-674',	35000,	32,	36,	in_id_bank),
('675-681', 50000,	30,	36,	in_id_bank),
('682-688',	80000,	25,	48,	in_id_bank),
('689-693',	150000,	20,	48,	in_id_bank);

status = 0;

--EXCEPTION WHEN OTHERS THEN
--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';

SELECT cw.new_score_for_bank(5);