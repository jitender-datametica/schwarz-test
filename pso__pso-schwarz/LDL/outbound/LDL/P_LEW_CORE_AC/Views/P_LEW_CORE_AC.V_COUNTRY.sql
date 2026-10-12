CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_country (country_sid, src_country_lidl_cd, src_lang_id, country_name,
country_grp_sid, lang_sid, lang_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT country_sid,
 src_country_lidl_cd,
 src_lang_id,
 country_name,
 country_grp_sid,
 lang_sid,
 lang_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_country;