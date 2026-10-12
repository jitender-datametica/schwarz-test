CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_company (company_id, company_name, country_pol_cd,
street_name, lob_cd, house_nr, city_name, zip) AS SELECT company_id,
 company_name,
 country_pol_cd,
 street_name,
 lob_cd,
 house_nr,
 city_name,
 zip
FROM szd_core.t_dim_store_hist;