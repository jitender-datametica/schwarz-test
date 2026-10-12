/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	V_dim_calendar_date
Description		  | Date
Created on        |	29.11.2022
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_calendar_date (cal_dt, day_of_week, month_of_year, weekend_fg,
day_of_cy, cy_month, cy_week, cy, bus_year, cal_dt_prev_7d, cal_dt_swday_prev_1y, cy_day_seq) AS SELECT cal_dt,
 day_of_week,
 month_of_year,
 weekend_fg,
 day_of_cy,
 cy_month,
 cy_week,
 cy,
 bus_year,
 cal_dt_prev_7d,
 cal_dt_swday_prev_1y,
 cy_day_seq
FROM ldl_score_core.t_dim_calendar_date;