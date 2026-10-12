/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_cal_calendarday_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-02      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE view v_cal_calendarday_2 for calendar_2 dates
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_CAL_CALENDARDAY_2(
	CAL_DT,
	MSTR_DAY_OF_WEEK,
	DAY_OF_WEEK,
	DAY_OF_MONTH,
	DAY_OF_CY,
	CY,
	CY_WEEK,
	CY_WEEK_99,
	CY_WEEK_PART,
	CY_MONTH,
	CY_MONTH_PREV_1M,
	BUSYEAR,
	CAL_DT_PREV_1D,
	CAL_DT_PREV_7D,
	CAL_DT_PREV_1Y,
	CAL_DT_PREV_2Y,
	CAL_DT_PREV_3Y,
	CAL_DT_PREV_4Y,
	CAL_DT_PREV_5Y,
	CAL_DT_PREV_YD,
	CAL_DT_PREV_MD,
	CAL_DT_PREV_PY,
	CAL_DT_SWDAY_PREV_1Y,
	CAL_DT_SWDAY_PREV_2Y,
	CAL_DT_SWDAY_PREV_3Y,
	CAL_DT_SWDAY_PREV_4Y,
	CAL_DT_SWDAY_PREV_5Y,
	CAL_DT_SWDAY_PREV_1Y_1W,
	CAL_DT_LAST_DAY_PREV_1W,
	CAL_DT_LAST_DAY_PREV_1M,
	CAL_DT_LAST_DAY_PREV_1Y,
	CAL_DT_FIRST_DAY_NEXT_1W,
	LAST_DAY_WEEK_FG,
	LAST_DAY_WEEK_PARTIAL_FG,
	LAST_DAY_MONTH_FG,
	LAST_DAY_YEAR_FG,
	CY_DAY_SEQ,
	CY_WEEK_SEQ,
	CY_MONTH_SEQ,
	BUSYEAR_SEQ,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_SRC
) COMMENT='Calendar_2 hierarchy_2 master data - view based on mv_cal_calendarday_2'
 AS 
SELECT
    cal_dt
    ,CASE 
    	WHEN day_of_week = 7 THEN 1
    	WHEN day_of_week = 1 THEN 2
    	WHEN day_of_week = 2 THEN 3
    	WHEN day_of_week = 3 THEN 4
    	WHEN day_of_week = 4 THEN 5
    	WHEN day_of_week = 5 THEN 6
    ELSE 7
    END AS mstr_day_of_week
    ,day_of_week
    ,day_of_month
    ,day_of_cy
    ,cy
    ,cy_week
    ,cy_week_99
    ,cy_week_part
    ,cy_month
    ,cy_month_prev_1m
    ,busyear
    ,cal_dt_prev_1d
    ,cal_dt_prev_7d
    ,cal_dt_prev_1y
    ,cal_dt_prev_2y
    ,cal_dt_prev_3y
    ,cal_dt_prev_4y
    ,cal_dt_prev_5y
    ,cal_dt_prev_yd
    ,cal_dt_prev_md
    ,cal_dt_prev_py
    ,cal_dt_swday_prev_1y
    ,cal_dt_swday_prev_2y
    ,cal_dt_swday_prev_3y
    ,cal_dt_swday_prev_4y
    ,cal_dt_swday_prev_5y
    ,cal_dt_swday_prev_1y_1w
    ,cal_dt_last_day_prev_1w
    ,cal_dt_last_day_prev_1m
    ,cal_dt_last_day_prev_1y
    ,cal_dt_first_day_next_1w
    ,last_day_week_fg
    ,last_day_week_partial_fg
    ,last_day_month_fg
    ,last_day_year_fg
    ,cy_day_seq
    ,cy_week_seq
    ,cy_month_seq
    ,busyear_seq
    ,dwh_load_id
    ,dwh_created
    ,dwh_src
FROM "DATA".t_cal_calendarday_2;
