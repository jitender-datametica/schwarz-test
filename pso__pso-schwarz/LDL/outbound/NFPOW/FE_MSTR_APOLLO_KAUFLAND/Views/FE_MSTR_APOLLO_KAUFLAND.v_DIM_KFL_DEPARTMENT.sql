CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_department (kfl_client_id, kfl_department_id,
kfl_department_name) AS SELECT kfl_client_id,
 kfl_department_id,
 kfl_department_name
FROM nfpow_core.t_dim_kfl_department;