CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_translation (desc_id, language_id, translation, table_name) AS
SELECT desc_id,
 language_id,
 translation,
 table_name
FROM ldl_p_lew_core.t_wawi_ref_translation;