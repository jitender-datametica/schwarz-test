/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      t_cal_calendarday_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Table t_cal_calendarday_2 for calendar_2 dates
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_cal_calendarday_2 (
cal_dt DATE,
day_of_week BIGNUMERIC(38,0),
day_of_month BIGNUMERIC(38,0),
day_of_cy BIGNUMERIC(38,0),
cy BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0),
cy_week_99 BIGNUMERIC(38,0),
cy_week_part BIGNUMERIC(38,0),
cy_month BIGNUMERIC(38,0),
cy_month_prev_1m BIGNUMERIC(38,0),
busyear BIGNUMERIC(38,0),
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
last_day_week_fg BIGNUMERIC(38,0),
last_day_week_partial_fg BIGNUMERIC(38,0),
last_day_month_fg BIGNUMERIC(38,0),
last_day_year_fg BIGNUMERIC(38,0),
cy_day_seq BIGNUMERIC(38,0),
cy_week_seq BIGNUMERIC(38,0),
cy_month_seq BIGNUMERIC(38,0),
busyear_seq BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_src STRING(50)
) OPTIONS(description='Calendar_2 hierarchy_2 master data');