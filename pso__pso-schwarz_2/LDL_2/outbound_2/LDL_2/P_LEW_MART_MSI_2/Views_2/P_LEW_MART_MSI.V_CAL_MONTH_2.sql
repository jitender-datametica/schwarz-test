CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_month_2 (cy_month, prev_month, prev_cy_month, preprev_cy_month, cy, byr,
cy_month_sequence, month_id) AS SELECT cy_month,
 prev_month,
 prev_cy_month,
 preprev_cy_month,
 cy,
 byr,
 cy_month_sequence,
 month_id
FROM ldl_p_lew_mart_msi.t_cal_month_2;