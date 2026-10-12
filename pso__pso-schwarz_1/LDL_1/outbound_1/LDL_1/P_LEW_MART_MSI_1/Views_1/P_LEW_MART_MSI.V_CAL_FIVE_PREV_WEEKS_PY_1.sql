CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_five_prev_weeks_py_1 (cy_week, prev_week, prev_week_py, diff_week_sequence
) AS SELECT cy_week,
 prev_week,
 prev_week_py,
 diff_week_sequence
FROM ldl_p_lew_mart_msi.t_cal_five_prev_weeks_py_1;