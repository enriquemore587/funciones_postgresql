
CREATE OR REPLACE FUNCTION cw.save_update_user_payroll_receipt (
	IN in_id INTEGER,
	IN in_fiscal_folio VARCHAR,
	IN in_fecha DATE,
	IN in_monto FLOAT,
	IN in_user_id VARCHAR,
	OUT status INTEGER
)AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 from cw.users as u WHERE u.id = in_user_id::uuid) THEN
		status = 1100;
	ELSE
		IF EXISTS (SELECT 1 FROM cw.user_payroll_receipt WHERE id = in_id) THEN
			UPDATE cw.user_payroll_receipt SET 
				fiscal_folio = in_fiscal_folio,
				fecha = in_fecha,
				monto = in_monto,
				user_id = in_user_id::uuid
			WHERE id = in_id;
			status = 0;
		ELSE
			INSERT INTO cw.user_payroll_receipt ( fiscal_folio, fecha, monto, user_id ) VALUES ( in_fiscal_folio, in_fecha, in_monto, in_user_id::uuid );
			status = 0;
		END IF;
	END IF;
	EXCEPTION WHEN OTHERS THEN
	--EXCEPTION BY SQL ERROR
	status = 1200;
END;
$$ LANGUAGE 'plpgsql';


SELECT cw.save_update_user_payroll_receipt(0, '1234567890', '1990-01-01', 5255.525, 'ad59d3ed-5ffe-4687-a6f6-314f0e0d691d');