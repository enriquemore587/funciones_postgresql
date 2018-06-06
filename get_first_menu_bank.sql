CREATE OR REPLACE FUNCTION cw.get_first_menu_bank(IN in_id_profile INTEGER)
  RETURNS TABLE (
    id   INTEGER,
		menu VARCHAR
) AS
$$
BEGIN
  RETURN QUERY
	SELECT menu."id"::INTEGER, menu.nombre::VARCHAR as name FROM cw.menu as menu
	INNER JOIN cw.profile_menu as pm ON menu."id" = pm.menu_id
	WHERE pm.profile_id = in_id_profile ORDER BY menu."id" ASC ;
END
$$  LANGUAGE plpgsql;

SELECT cw.get_first_menu_bank(4);


