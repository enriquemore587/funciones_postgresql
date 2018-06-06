CREATE OR REPLACE FUNCTION cw.set_list_bank_custom_variables (
	IN in_variables INTEGER ARRAY,
	IN in_bank_id INTEGER,
	OUT status INTEGER
) AS $$
DECLARE m   integer[];
DECLARE _temp INTEGER;
DECLARE exit INTEGER;
BEGIN
	

	DELETE FROM cw.bank_follow_variables WHERE bank_id = in_bank_id;
	

	--	1 => variable_id
	--	2 => personal_variable_id
		FOREACH m SLICE 1 IN ARRAY in_variables
		 LOOP
				
				IF m[3]::INTEGER != 0 THEN
								_temp := m[1]::INTEGER;

								IF _temp = 0 THEN
											INSERT INTO cw.bank_follow_variables (personal_variable_id, bank_id, "short")
											VALUES (m[2], in_bank_id, m[3]);

								ELSE

											_temp := m[2]::INTEGER;

											IF _temp = 0 THEN

														INSERT INTO cw.bank_follow_variables (variable_id, bank_id, short)
														VALUES (m[1], in_bank_id, m[3]);

											END IF;

								END IF;
					
				END IF;
/*
INSERT INTO cw.bank_follow_variables (personal_variable_id, variable_id)
					VALUES (m[1], m[2]);
*/
				
		END LOOP;
		status = 0;
--EXCEPTION WHEN OTHERS THEN
	--status = 1200;
END ; 
$$ LANGUAGE 'plpgsql';


--		[1]default variable, [2]custom variable
--SELECT cw.set_list_bank_custom_variables (ARRAY [[0,28,1],[14,0,2],[14,0,3],[0,28,4],[0,28,5]], 5);
SELECT cw.set_list_bank_custom_variables (ARRAY [[0,0,0]], 5);
