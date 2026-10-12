CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_lp_language AS SELECT language_id,
 language_desc,
 language_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_ref_language AS L;