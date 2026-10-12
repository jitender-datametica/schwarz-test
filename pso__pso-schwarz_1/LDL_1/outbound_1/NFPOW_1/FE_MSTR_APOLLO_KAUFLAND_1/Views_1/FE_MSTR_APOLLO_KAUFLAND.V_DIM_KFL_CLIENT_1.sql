CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_client_1 (kfl_client_id, kfl_client_cd, kfl_client_name,
curr_cd, kfl_orig_client_id) AS SELECT kfl_client_id,
 kfl_client_cd,
 kfl_client_name,
 curr_cd,
 kfl_orig_client_id
FROM nfpow_core.t_dim_kfl_client_1;