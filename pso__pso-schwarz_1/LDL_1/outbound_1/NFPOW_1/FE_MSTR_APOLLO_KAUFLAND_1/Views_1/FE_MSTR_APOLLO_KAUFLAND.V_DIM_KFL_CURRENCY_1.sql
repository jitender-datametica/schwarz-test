CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_currency_1 (curr_cd, kfl_curr_name) AS SELECT curr_cd,
 kfl_curr_name
FROM nfpow_core.t_dim_kfl_currency_1;