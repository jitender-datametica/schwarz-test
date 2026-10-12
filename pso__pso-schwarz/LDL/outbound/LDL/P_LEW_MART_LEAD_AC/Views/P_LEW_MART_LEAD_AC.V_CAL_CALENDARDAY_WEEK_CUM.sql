CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cal_calendarday_week_cum (cal_dt, cal_dt_week_cum, cy, cy_month, cy_week
, day_of_cy, day_of_month, day_of_week) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cal_calendarday_week_cum;