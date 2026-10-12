CREATE OR REPLACE VIEW ldl_scm_core.v_cal_month_1 (cy_month, prev_month, prev_cy_month, preprev_cy_month, cy, byr,
cy_month_sequence, month_id, month_name) AS SELECT MOD(CD.cy_month, 100) AS cy_month,
   EXTRACT(YEAR FROM IF(CD.cal_dt = LAST_DAY(CD.cal_dt), LAST_DAY(DATE_ADD(CD.cal_dt, INTERVAL - 1 MONTH)), DATE_ADD(CD
      .cal_dt, INTERVAL - 1 MONTH))) * 100 + EXTRACT(MONTH FROM IF(CD.cal_dt = LAST_DAY(CD.cal_dt), LAST_DAY(DATE_ADD(CD
      .cal_dt, INTERVAL - 1 MONTH)), DATE_ADD(CD.cal_dt, INTERVAL - 1 MONTH))) AS prev_month,
   EXTRACT(YEAR FROM IF(CD.cal_dt = LAST_DAY(CD.cal_dt), LAST_DAY(DATE_ADD(CD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(CD
      .cal_dt, INTERVAL - 12 MONTH))) * 100 + EXTRACT(MONTH FROM IF(CD.cal_dt = LAST_DAY(CD.cal_dt), LAST_DAY(DATE_ADD(CD
      .cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(CD.cal_dt, INTERVAL - 12 MONTH))) AS prev_cy_month,
   EXTRACT(YEAR FROM IF(CD.cal_dt = LAST_DAY(CD.cal_dt), LAST_DAY(DATE_ADD(CD.cal_dt, INTERVAL - 24 MONTH)), DATE_ADD(CD
      .cal_dt, INTERVAL - 24 MONTH))) * 100 + EXTRACT(MONTH FROM IF(CD.cal_dt = LAST_DAY(CD.cal_dt), LAST_DAY(DATE_ADD(CD
      .cal_dt, INTERVAL - 24 MONTH)), DATE_ADD(CD.cal_dt, INTERVAL - 24 MONTH))) AS preprev_cy_month,
  CD.cy_month / 100 AS cy,
 CD.busyear AS byr,
    CD.cy_month - CD.cy * 100 - EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) + (CD.cy - EXTRACT(YEAR FROM
      DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))) * 12 AS cy_month_sequence,
 MOD(CD.cy_month, 100) AS month_id,
 MD.month_desc AS month_name
FROM ldl_scm_core.v_cal_calendarday_1 AS CD
 INNER JOIN ldl_scm_core_rel.t_month_desc_1 AS MD ON MD.month_id = MOD(CD.cy_month, 100)
GROUP BY CD.cy_month,core.v_cal_month_1
 prev_month,
 prev_cy_month,
 preprev_cy_month,
 cy,
 byr,
 cy_month_sequence,
 month_id,
 month_name;