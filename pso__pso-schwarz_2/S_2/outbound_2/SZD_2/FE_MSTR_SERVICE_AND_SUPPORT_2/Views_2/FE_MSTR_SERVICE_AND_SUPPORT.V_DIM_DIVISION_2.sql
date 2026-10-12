CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_dim_division_2 (division_cd, division_name) AS SELECT division_cd
 ,
 division_name
FROM szd_core.t_dim_division_2
WHERE dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP);