CREATE OR REPLACE FUNCTION cw.getCatsByCP (IN in_cp VARCHAR)
  RETURNS TABLE (
    colonia   VARCHAR, 
		estado VARCHAR,
		id_estado INTEGER,
		municipio VARCHAR,
		id_municipio INTEGER) AS
$$
BEGIN
  RETURN QUERY

	SELECT col.colonia::VARCHAR, st.descripcion::VARCHAR, st."id"::INTEGER as id_estado, mun.descripcion::VARCHAR as municipio, mun."id"::INTEGER as id_municipio FROM "cw"."colony" as col 
	INNER JOIN cw.municipalities as mun ON col.id_mnpio = mun."id" AND col.id_estado = mun.id_states
	INNER JOIN cw.states as st ON col.id_estado = st.id
	WHERE col.cp = in_cp;

END
$$  LANGUAGE plpgsql;


SELECT cw.getcatsbycp('55100');