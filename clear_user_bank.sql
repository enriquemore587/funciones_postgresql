CREATE
OR REPLACE FUNCTION cw.clear_user_bank (
	IN in_bank_id INTEGER,
	IN in_user_id VARCHAR,
	OUT status INTEGER
) AS $$
BEGIN

DELETE FROM cw.bank_follow_variables WHERE bank_id = in_bank_id;

DELETE FROM cw.bank_custom_variables WHERE bank_id = in_bank_id;

DELETE FROM cw.bank_variables WHERE bank_id = in_bank_id;

DELETE FROM cw.users_bank WHERE user_id = in_user_id::uuid;

SELECT cw.set_user_bank(in_bank_id, in_user_id) into status;

END;
$$ LANGUAGE 'plpgsql';

SELECT cw.clear_user_bank ( 5, 'c28eda62-4939-4ec9-9ac8-9808768e2a76' );