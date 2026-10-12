CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_gtp_type_1 (kfl_gtp_type_id, kfl_gtp_type_name) AS SELECT
 kfl_gtp_type_id,
 kfl_gtp_type_name
FROM nfpow_core.t_dim_kfl_gtp_type_1;