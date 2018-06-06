CREATE OR REPLACE FUNCTION cw.get_ocupation()
  RETURNS TABLE (
    id   INTEGER,
		name VARCHAR
) AS
$$
BEGIN
  RETURN QUERY
	SELECT c.id::INTEGER, c.name FROM cw.occupations AS c;
END
$$  LANGUAGE plpgsql;


SELECT cw.get_ocupation();