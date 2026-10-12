CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_like_for_like_descr_1 (lfl_id, lfl_descr, lfl_descr_en, dwh_load_id,
dwh_created, dwh_updated) AS SELECT lfl_id,
 lfl_descr,
 lfl_descr_en,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_like_for_like_descr_1;