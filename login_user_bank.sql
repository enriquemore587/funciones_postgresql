CREATE
OR REPLACE FUNCTION cw.login_user_bank (IN in_id_user VARCHAR) RETURNS TABLE (
	id_user VARCHAR,
	id_profile INTEGER,
	name_profile VARCHAR,
	id_bank INTEGER,
	name_bank VARCHAR
) AS $$
BEGIN
	RETURN QUERY SELECT
		u."id" :: VARCHAR AS id_user,
		u.id_profile :: INTEGER,
		pr.description :: VARCHAR AS name_profile,
		b."id" :: INTEGER AS id_bank,
		b.name_bank :: VARCHAR
	FROM
		cw.users AS u
	INNER JOIN cw.profiles AS pr ON u.id_profile = pr."id"
	INNER JOIN cw.users_bank AS ub ON ub.user_id = u."id"
	INNER JOIN cw.banks AS b ON ub.bank_id = b."id"
	WHERE
		u. ID = in_id_user :: uuid ;
	END ; $$ LANGUAGE plpgsql;

SELECT
	cw.login_user_bank (
		'c28eda62-4939-4ec9-9ac8-9808768e2a76'
	);