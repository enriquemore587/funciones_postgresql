CREATE OR REPLACE FUNCTION cw.getHelp_score(IN in_start_range INTEGER, OUT status INTEGER, OUT resp json)
AS $$

DECLARE
			tables CURSOR FOR
					SELECT id, range, deadline
					FROM cw.score_buro
			ORDER BY  id ASC;
			myvalue INTEGER ARRAY;
			_data text;

	BEGIN

			FOR table_record IN tables LOOP

			select regexp_split_to_array(table_record."range", '-') INTO myvalue;

					IF in_start_range >= myvalue[1] THEN

						
						SELECT '{"id": "'||table_record.id::TEXT||'", "desde": "'||in_start_range||'", "range": "'||myvalue[2]::TEXT||'", "plazo" : "'||table_record.deadline||'"}' into _data;
							
						SELECT _data::json into resp;
						status  = 0;
						--SELECT '{"bar": "baz", "balance": 7.77, "active":false}'::json into resp;
						--SELECT '{"bar": "baz", "balance": 7.77, "active":false}'::json;
					END IF;

			END LOOP;

END;
$$ LANGUAGE 'plpgsql';

SELECT cw.getHelp_score(0690);