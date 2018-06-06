CREATE OR REPLACE FUNCTION cw.get_civil_status()
  RETURNS TABLE (
    id   INTEGER,
		descripcion VARCHAR
) AS
$$
BEGIN
  RETURN QUERY
	SELECT c.id, c.descripcion FROM cw.civil_status AS c;
END
$$  LANGUAGE plpgsql;


SELECT cw.get_civil_status();