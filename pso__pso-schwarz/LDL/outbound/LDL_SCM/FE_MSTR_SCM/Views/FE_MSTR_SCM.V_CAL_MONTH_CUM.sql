CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_cal_month_cum (busyear, cal_month, month_byr_cum, month_prev_byr_cum,
month_pprev_byr_cum) AS SELECT A.busyear,
 A.cy_month AS cal_month,
 B.cy_month AS month_byr_cum,
  B.cy_month - 100 AS month_prev_byr_cum,
  B.cy_month - 200 AS month_pprev_byr_cum
FROM ldl_scm_core_rel.v_cal_calendarday AS A
 INNER JOIN ldl_scm_core_rel.v_cal_calendarday AS B ON A.busyear = B.busyear AND A.cy_month >= B.cy_month
GROUP BY A.busyear,
 cal_month,
 month_byr_cum,
 month_prev_byr_cum,
 month_pprev_byr_cum
ORDER BY cal_month NULLS LAST;