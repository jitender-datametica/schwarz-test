CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_like_for_like_description_1 (lfl_id, lfl_descr, lfl_descr_en) AS SELECT
 lfl_id,
 lfl_descr,
 lfl_descr_en
FROM ldl_p_lew_core_ac.v_ref_lil_like_for_like_descr_1;