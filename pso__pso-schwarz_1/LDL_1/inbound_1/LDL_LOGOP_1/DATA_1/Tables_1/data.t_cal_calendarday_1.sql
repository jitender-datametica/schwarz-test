/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_cal_calendarday_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_cal_calendarday_1 for calendar_1 dates
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE DATA.t_cal_calendarday_1 (
	cal_dt DATE,
	day_of_week NUMBER(38,0),
	day_of_month NUMBER(38,0),
	day_of_cy NUMBER(38,0),
	cy NUMBER(38,0),
	cy_week NUMBER(38,0),
	cy_week_99 NUMBER(38,0),
	cy_week_part NUMBER(38,0),
	cy_month NUMBER(38,0),
	cy_month_prev_1m NUMBER(38,0),
	busyear NUMBER(38,0),
	cal_dt_prev_1d DATE,
	cal_dt_prev_7d DATE,
	cal_dt_prev_1y DATE,
	cal_dt_prev_2y DATE,
	cal_dt_prev_3y DATE,
	cal_dt_prev_4y DATE,
	cal_dt_prev_5y DATE,
	cal_dt_prev_yd DATE,
	cal_dt_prev_md DATE,
	cal_dt_prev_py DATE,
	cal_dt_swday_prev_1y DATE,
	cal_dt_swday_prev_2y DATE,
	cal_dt_swday_prev_3y DATE,
	cal_dt_swday_prev_4y DATE,
	cal_dt_swday_prev_5y DATE,
	cal_dt_swday_prev_1y_1w DATE,
	cal_dt_last_day_prev_1w DATE,
	cal_dt_last_day_prev_1m DATE,
	cal_dt_last_day_prev_1y DATE,
	cal_dt_first_day_next_1w DATE,
	last_day_week_fg NUMBER(38,0),
	last_day_week_partial_fg NUMBER(38,0),
	last_day_month_fg NUMBER(38,0),
	last_day_year_fg NUMBER(38,0),
	cy_day_seq NUMBER(38,0),
	cy_week_seq NUMBER(38,0),
	cy_month_seq NUMBER(38,0),
	busyear_seq NUMBER(38,0),
	dwh_load_id NUMBER(38,0),
	dwh_created TIMESTAMP,
	dwh_src VARCHAR(50)
) COMMENT = 'Calendar_1 hierarchy_1 master data'
;
