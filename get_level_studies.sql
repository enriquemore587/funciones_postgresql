CREATE OR REPLACE FUNCTION cw.get_level_studies()
  RETURNS TABLE (
    id   INTEGER,
		description VARCHAR
) AS
$$
BEGIN
  RETURN QUERY
	SELECT L.id, L.description FROM cw.level_studies AS L;
END
$$  LANGUAGE plpgsql;


SELECT cw.get_level_studies();