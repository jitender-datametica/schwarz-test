CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_month_1 (cy_month, prev_month, prev_cy_month, preprev_cy_month, cy,
busyear, cy_month_sequence, month_id) AS SELECT cy_month,
 prev_month,
 prev_cy_month,
 preprev_cy_month,
 cy,
 busyear,
 cy_month_sequence,
 month_id
FROM ldl_p_lew_core.t_wawi_cal_month_1;