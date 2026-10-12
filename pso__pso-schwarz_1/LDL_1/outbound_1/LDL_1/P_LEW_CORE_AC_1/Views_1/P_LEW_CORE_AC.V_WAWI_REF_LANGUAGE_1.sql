CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_language_1 (language_id, language_iso_cd, language_desc, load_id) AS
SELECT language_id,
 language_iso_cd,
 language_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_language_1;