CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_cal_calmonth_2 (cal_month, prev_month, prev_cy_month, preprev_cy_month,
preprevprev_cy_month, cy, busyear, cy_month_seq, month_id, month_name) AS SELECT cy_month AS cal_month,
 prev_month,
 prev_cy_month,
 preprev_cy_month,
 preprevprev_cy_month,
 cy,
 byr AS busyear,
 cy_month_sequence AS cy_month_seq,
 month_id,
 CONCAT(month_name, ' ', LEFT(SUBSTR(CAST(cy_month AS STRING), 1, 10), 4)) AS month_name
FROM ldl_scm_core_rel.v_cal_month_2;