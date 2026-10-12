CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_artikel_year_month_week_1 (ba_nr, busyear, cal_month, cal_week, month_seq) AS
SELECT DISTINCT B.ba_nr,
 MON.busyear,
 MON.cy_month AS cal_month,
 MON.cy_week AS cal_week,
 MON.cy_month_sequence AS month_seq
FROM ldl_scm_core_rel.v_busyear_month_week_1 AS MON
 INNER JOIN (SELECT ba_nr,
   busyear,
   MIN(start_month) AS sm_1,
   MAX(end_month) AS em,
   cy_month_sequence
  FROM ldl_scm_core_rel.v_busyear_month_week_1
  GROUP BY cy_month_sequence,
   ba_nr,
   busyear) AS B ON MON.busyear = B.busyear AND MON.cy_month BETWEEN B.sm_1 AND B.em;