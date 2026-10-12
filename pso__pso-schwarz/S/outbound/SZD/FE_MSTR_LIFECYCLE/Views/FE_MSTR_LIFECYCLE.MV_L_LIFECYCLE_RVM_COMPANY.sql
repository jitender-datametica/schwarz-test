CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_l_lifecycle_rvm_company AS SELECT company_id,
 company_name,
 country_pol_cd,
 street_name,
 lob_cd,
 house_nr,
 city_name,
 zip
FROM szd_core.t_dim_company;