CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_client_country (kfl_client_id, kfl_country_cd,
kfl_country_name) AS SELECT kfl_client_id,
 kfl_country_cd,
 kfl_country_name
FROM nfpow_core.t_dim_kfl_client_country;