CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_week_1 (cy_week, prev_week, prev_cy_week, preprev_cy_week, cy_week_name,
cy_week_short_name, cy_week_sequence) AS SELECT cy_week,
 prev_week,
 prev_cy_week,
 preprev_cy_week,
 cy_week_name,
 cy_week_short_name,
 cy_week_sequence
FROM ldl_p_lew_mart_msi.t_cal_week_1;