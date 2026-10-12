CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_month (cy_month, prev_month, prev_cy_month, preprev_cy_month, cy,
byr, cy_month_sequence, month_id) AS SELECT cy_month,
 cy_month_prev_1m AS prev_month,
 cy_month_prev_1y AS prev_cy_month,
 cy_month_prev_2y AS preprev_cy_month,
 cy,
 busyear AS byr,
 cy_month_seq AS cy_month_sequence,
 month_id
FROM ldl_p_lew_core_ac.v_cal_month AS C1
WHERE cy < (SELECT MAX(cy) - 6
   FROM ldl_p_lew_core_ac.v_cal_month);