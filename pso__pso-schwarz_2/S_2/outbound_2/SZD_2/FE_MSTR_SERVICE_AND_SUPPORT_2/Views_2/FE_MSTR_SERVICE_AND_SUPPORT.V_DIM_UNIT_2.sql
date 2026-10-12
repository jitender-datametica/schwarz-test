CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_dim_unit_2 (unit_id, unit_name) AS SELECT unit_id,
 unit_name
FROM szd_core.t_dim_unit_2;