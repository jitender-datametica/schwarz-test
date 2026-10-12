CREATE OR REPLACE VIEW szd_production_fe_mstr_service_and_support.v_dim_division (division_cd, division_name) AS SELECT
 division_cd,
 division_name
FROM szd_production_core.t_dim_division
WHERE dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP);