CREATE OR REPLACE FUNCTION cw.getContries ()
  RETURNS TABLE (
    id   VARCHAR, 
		name VARCHAR,
		iso2 VARCHAR,
		iso3 VARCHAR) AS
$$
BEGIN
  RETURN QUERY
	SELECT c.id, c.name, c.iso2, c.iso3
	FROM cw.countries as c;
END
$$  LANGUAGE plpgsql;


SELECT cw.getcontries();