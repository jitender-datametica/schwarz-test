CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_lang_spras_1 (language_id, language_iso_cd, language_desc, sap_spras,
sap_lang_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT language_id,
 language_iso_cd,
 language_desc,
 sap_spras,
 sap_lang_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_lang_spras_1;