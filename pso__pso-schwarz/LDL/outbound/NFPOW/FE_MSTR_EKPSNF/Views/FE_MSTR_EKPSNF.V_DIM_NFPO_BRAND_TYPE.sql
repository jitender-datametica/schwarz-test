CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_brand_type (nfpo_brand_type_cd, nfpo_brand_type_name,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_brand_type;