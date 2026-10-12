CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_home_brand (kfl_client_id, kfl_home_brand_cd,
kfl_home_brand_name) AS SELECT kfl_client_id,
 kfl_home_brand_cd,
 kfl_home_brand_name
FROM nfpow_core.t_dim_kfl_home_brand;