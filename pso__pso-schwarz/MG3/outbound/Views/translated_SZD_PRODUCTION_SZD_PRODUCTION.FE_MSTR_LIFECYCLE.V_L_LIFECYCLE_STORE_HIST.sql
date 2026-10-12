CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_l_lifecycle_store_hist (store_sid, lob_cd, lob_name,
company_name, company_id, store_nr, store_name, store_active_fg, street_name, house_nr, city_name, zip, country_pol_cd,
country_pol_name) AS SELECT store_sid,
 lob_cd,
 lob_name,
 company_name,
 company_id,
 store_nr,
 store_name,
 store_active_fg,
 street_name,
 house_nr,
 city_name,
 zip,
 country_pol_cd,
 country_pol_name
FROM szd_production_core.t_dim_store_hist
WHERE dwh_valid_fg
 AND store_active_fg;