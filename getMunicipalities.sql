CREATE OR REPLACE FUNCTION cw.getMunicipalities()
  RETURNS TABLE (
    id   INTEGER, 
		id_states INTEGER,
		descripcion VARCHAR
	) AS
$$
BEGIN
  RETURN QUERY
	SELECT m.id, 
	m.id_states, 
	m.descripcion
	FROM cw.municipalities as m;
END
$$  LANGUAGE plpgsql;
/*
select cw.getmunicipalities()
SELECT *FROM cw.municipalities as m;*/