CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_l_lifecycle_line_of_business_1 (lob_cd, lob_name) AS SELECT
 lob_cd,
 lob_name
FROM szd_production_core.t_dim_line_of_business_1
WHERE lob_cd = 'K'
 OR lob_cd = 'L';