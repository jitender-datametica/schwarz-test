CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_report_language_1 (lang_sid, src_spras, lang_name, iso_cd, dwh_load_id,
dwh_created, dwh_updated) AS SELECT lang_sid,
 src_spras,
 lang_name,
 iso_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_report_language_1;