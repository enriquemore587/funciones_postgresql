CREATE OR REPLACE FUNCTION cw.get_nationalities()
  RETURNS TABLE (
    id   INTEGER,
		name VARCHAR
) AS
$$
BEGIN
  RETURN QUERY
	SELECT c.id::INTEGER, c.description as name FROM cw.nationalities AS c;
END
$$  LANGUAGE plpgsql;


SELECT cw.get_nationalities();