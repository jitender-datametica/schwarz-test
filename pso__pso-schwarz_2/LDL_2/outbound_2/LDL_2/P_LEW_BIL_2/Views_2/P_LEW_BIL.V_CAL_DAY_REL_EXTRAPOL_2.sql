CREATE OR REPLACE VIEW ldl_p_lew_bil.v_cal_day_rel_extrapol_2 AS SELECT cal_dt,
 DATE_SUB(cal_dt, INTERVAL 7 DAY) AS dat_calendar_extrapol
FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS A
UNION ALL
SELECT cal_dt,
 DATE_SUB(cal_dt, INTERVAL 14 DAY) AS dat_calendar_extrapol
FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS A
UNION ALL
SELECT cal_dt,
 DATE_SUB(cal_dt, INTERVAL 21 DAY) AS dat_calendar_extrapol
FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS A
UNION ALL
SELECT cal_dt,
 DATE_SUB(cal_dt, INTERVAL 28 DAY) AS dat_calendar_extrapol
FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS A
UNION ALL
SELECT cal_dt,
 DATE_SUB(cal_dt, INTERVAL 35 DAY) AS dat_calendar_extrapol
FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS A;