CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_country_political_descr (client_id, country_pol_sid, lang_sid, lang_cd,
country_pol_descr, nationality, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 country_pol_sid,
 lang_sid,
 lang_cd,
 country_pol_descr,
 nationality,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_country_political_descr;