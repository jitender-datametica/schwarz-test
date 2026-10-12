CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_load_status_source_asis_2 (source_id, source_desc, language_id,
mod_tmsp) AS SELECT source_id,
 source_desc,
 language_id,
 mod_tmsp
FROM ldl_p_lew_core.t_wawi_ref_load_status_source_asis_2;