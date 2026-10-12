CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cal_calendarday_month_cum (cal_dt, cal_dt_month_cum, cy, cy_month, cy_week
, day_of_cy, day_of_month, day_of_week) AS SELECT C1.cal_dt,
 C2.cal_dt AS cal_dt_month_cum,
 C2.cy,
 C2.cy_month,
 C2.cy_week,
 C2.day_of_cy,
 C2.day_of_month,
 C2.day_of_week
FROM ldl_p_lew_core_ac.v_cal_calendarday AS C1
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS C2 ON C1.cy_month = C2.cy_month AND C1.cal_dt >= C2.cal_dt;