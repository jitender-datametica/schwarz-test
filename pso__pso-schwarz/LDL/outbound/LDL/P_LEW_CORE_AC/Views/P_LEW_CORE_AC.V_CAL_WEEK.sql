CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_week (cy_week, cy_week_prev_1w, cy_week_prev_1y, cy_week_prev_2y,
cy_week_seq, dwh_load_id, dwh_created, dwh_updated) AS SELECT cy_week,
 cy_week_prev_1w,
 cy_week_prev_1y,
 cy_week_prev_2y,
 cy_week_seq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_week;