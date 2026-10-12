CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_period_2 (per_id, per_text, per_text_en, per_desc, per_desc_en,
per_tp_id, per_lvl, per_yr, per_start_dat, per_end_dat, py_per_id, py_per_desc, py_per_desc_en, pq_per_id, pq_per_desc,
pq_per_desc_en, pp_per_id, pp_per_desc, pp_per_desc_en, liam_avbl_fg, lift_avbl_fg) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_period_2;