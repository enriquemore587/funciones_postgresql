CREATE OR REPLACE FUNCTION cw.get_information_step2 (IN in_id_user VARCHAR)
RETURNS TABLE (
state_id INTEGER,
state_name VARCHAR,
municipality_id INTEGER,
municipality_name VARCHAR,
colony VARCHAR,
street VARCHAR,
ext VARCHAR,
inte VARCHAR,
cp VARCHAR,
additional_reference VARCHAR,
years_residence INTEGER,
country VARCHAR,
name_country VARCHAR
) AS
$$
BEGIN
	RETURN QUERY
	SELECT
	ua.state as state_id,
	st.descripcion as state_name,
	ua.municipality as municipality_id,
	mu.descripcion as municipality_name,
	ua.colony,
	ua.street,
	ua.ext,
	ua.int as inte,
	ua.cp,
	ua.additional_reference,
	ua.years_residence,
	ua.country,
	cu.name as name_country
 FROM cw.user_address as ua
	INNER JOIN cw.countries as cu ON cu.id = ua.country
	INNER JOIN cw.states as st ON st.id = ua.state
	INNER JOIN cw.municipalities as mu ON mu.id = ua.municipality
	WHERE ua.state = mu.id_states and ua.id = in_id_user::uuid;
END;
$$
LANGUAGE plpgsql;

SELECT cw.get_information_step2('41343e72-a624-4850-aed1-515395f12cec');