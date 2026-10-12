CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_week (cy_week, prev_week, prev_cy_week, preprev_cy_week,
cy_week_sequence) AS SELECT cy_week,
 prev_week,
 prev_cy_week,
 preprev_cy_week,
 cy_week_sequence
FROM ldl_p_lew_core.t_wawi_cal_week;