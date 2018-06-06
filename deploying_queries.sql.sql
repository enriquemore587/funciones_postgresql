SELECT * FROM cw.bank_variables as bv
WHERE bv.active = TRUE AND bv.bank_id = 5;

SELECT * FROM cw.categories_variables AS cv
WHERE cv.id = 1;

SELECT * FROM cw.variables_fix AS vf
WHERE vf.category_id = 1;

------

SELECT 
bv.var_fix_id, vf.name, bv."range", bv.is_ok, bv.var_array, bv.active as status

FROM cw.variables_fix AS vf
INNER JOIN cw.bank_variables as bv ON bv.var_fix_id = vf.id
WHERE vf.category_id = 1 AND bv.bank_id = 5 AND bv.product_id = 1;