CREATE OR REPLACE FUNCTION cw.get_information_step1 (IN id_user VARCHAR)
RETURNS TABLE (
	name VARCHAR,
	name2 VARCHAR,
	last_name VARCHAR,
	last_name2 VARCHAR,
	birthdate DATE,
	gender VARCHAR,
	phone VARCHAR,
	mobile_phone VARCHAR,
	rfc VARCHAR,
	curp VARCHAR,
	nationality INTEGER,
	nationality_description VARCHAR,
	country VARCHAR,
	country_description VARCHAR,
	entity_birth INTEGER,
	entity_birth_description VARCHAR,
	level_study INTEGER,
	level_study_description VARCHAR,
	civil_status INTEGER,
	american_citizenship CHAR,
	mobile_phone_company VARCHAR,
	folio_ine VARCHAR,
	clave_electoral VARCHAR
) AS
$$
BEGIN
  RETURN QUERY
	SELECT  ud.name, ud.name2, ud.last_name, ud.last_name2, ud.birthdate, 
	ud.gender, ud.phone, ud.mobile_phone, ud.rfc, ud.curp, ud.nationality,  nat.description as nationality_description,
	ud.country, cont.name as country_description,
	ud.entity_birth, st.descripcion as entity_birth_description, ud.level_study, ls.description::VARCHAR as level_study_description,
	ud.civil_status, ud.american_citizenship, ud.mobile_phone_company,
	ud.folio_ine, ud.clave_electoral
	FROM cw.user_personal_data as ud
	INNER JOIN cw.states as st on ud.entity_birth = st.id
	INNER JOIN cw.level_studies as ls on ud.level_study = ls.id
	INNER JOIN cw.nationalities as nat on ud.nationality = nat.id
	INNER JOIN cw.countries as cont on ud.country = cont.id

	WHERE ud.id = id_user::uuid;

END
$$  LANGUAGE plpgsql;


SELECT cw.get_information_step1('41343e72-a624-4850-aed1-515395f12cec');