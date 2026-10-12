CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_lcsd_descr_1 (lcsd_id, lang_cd, lcsd_descr, lcsd_short_descr,
lcsd_explain, dwh_load_id, dwh_created, dwh_updated) AS SELECT lcsd_id,
 lang_cd,
 lcsd_descr,
 lcsd_short_descr,
 lcsd_explain,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_lcsd_descr_1;