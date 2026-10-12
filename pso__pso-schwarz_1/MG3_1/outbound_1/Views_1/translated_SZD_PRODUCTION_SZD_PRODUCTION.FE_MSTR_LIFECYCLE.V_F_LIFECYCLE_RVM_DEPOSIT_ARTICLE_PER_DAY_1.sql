CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_rvm_deposit_article_per_day_1 (item_sid, rvm_sid,
lob_cd, country_pol_cd, item_gtin, return_dt, return_cnt, item_container_type_cd) AS SELECT item_sid,
 rvm_sid,
 lob_cd,
 country_pol_cd,
 item_gtin,
 return_dt,
 return_cnt,
 item_container_type_cd
FROM szd_production_core.t_fact_deposit_article_per_day_1;