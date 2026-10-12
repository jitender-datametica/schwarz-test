CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_supplier_1 (nfpo_sup_sid, nfpo_sup_nr, nfpo_sup_name,
nfpo_gtin_ownership_cd, nfpo_gtin_ownership_descr, nfpo_country_sid, nfpo_country_cd, nfpo_country_name, street_name,
city_name, zip, eks_sup_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_supplier_1;