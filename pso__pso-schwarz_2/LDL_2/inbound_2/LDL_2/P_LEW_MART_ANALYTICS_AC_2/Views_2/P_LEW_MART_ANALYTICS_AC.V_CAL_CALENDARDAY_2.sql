CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_CAL_CALENDARDAY_2
/*
#DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Kalender Access Layer
#DescEnd#
*/
(
     cal_dt
,          day_of_week
,          day_of_month
,          day_of_cy
,          cy
,          cy_week
,          cy_week_99
,          cy_week_part
,          cy_month
,          cy_month_prev_1m
,          busyear
,          cal_dt_prev_1d
,          cal_dt_prev_7d
,          cal_dt_prev_1y
,          cal_dt_prev_2y
,          cal_dt_prev_3y
,          cal_dt_prev_4y
,          cal_dt_prev_5y
,          cal_dt_prev_yd
,          cal_dt_prev_md
,          cal_dt_prev_py
,          cal_dt_swday_prev_1y
,          cal_dt_swday_prev_2y
,          cal_dt_swday_prev_3y
,          cal_dt_swday_prev_4y
,          cal_dt_swday_prev_5y
,          cal_dt_swday_prev_1y_1w
,          cal_dt_last_day_prev_1w
,          cal_dt_last_day_prev_1m
,          cal_dt_last_day_prev_1y
,          cal_dt_first_day_next_1w
,          last_day_week_fg
,          last_day_week_partial_fg
,          last_day_month_fg
,          last_day_year_fg
,          cy_day_seq
,          cy_week_seq
,          cy_month_seq
,          busyear_seq
,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Cal.cal_dt                      AS cal_dt,
   Cal.day_of_week                 AS day_of_week,
   Cal.day_of_month                AS day_of_month,
   Cal.day_of_cy                   AS day_of_cy,
   Cal.cy                          AS cy,
   Cal.cy_week                     AS cy_week,
   Cal.cy_week_99                  AS cy_week_99,
   Cal.cy_week_part                AS cy_week_part,
   Cal.cy_month                    AS cy_month,
   Cal.cy_month_prev_1m            AS cy_month_prev_1m,
   Cal.busyear                     AS busyear,
   Cal.cal_dt_prev_1d              AS cal_dt_prev_1d,
   Cal.cal_dt_prev_7d              AS cal_dt_prev_7d,
   Cal.cal_dt_prev_1y              AS cal_dt_prev_1y,
   Cal.cal_dt_prev_2y              AS cal_dt_prev_2y,
   Cal.cal_dt_prev_3y              AS cal_dt_prev_3y,
   Cal.cal_dt_prev_4y              AS cal_dt_prev_4y,
   Cal.cal_dt_prev_5y              AS cal_dt_prev_5y,
   Cal.cal_dt_prev_yd              AS cal_dt_prev_yd,
   Cal.cal_dt_prev_md              AS cal_dt_prev_md,
   Cal.cal_dt_prev_py              AS cal_dt_prev_py,
   Cal.cal_dt_swday_prev_1y        AS cal_dt_swday_prev_1y,
   Cal.cal_dt_swday_prev_2y        AS cal_dt_swday_prev_2y,
   Cal.cal_dt_swday_prev_3y        AS cal_dt_swday_prev_3y,
   Cal.cal_dt_swday_prev_4y        AS cal_dt_swday_prev_4y,
   Cal.cal_dt_swday_prev_5y        AS cal_dt_swday_prev_5y,
   Cal.cal_dt_swday_prev_1y_1w     AS cal_dt_swday_prev_1y_1w,
   Cal.cal_dt_last_day_prev_1w     AS cal_dt_last_day_prev_1w,
   Cal.cal_dt_last_day_prev_1m     AS cal_dt_last_day_prev_1m,
   Cal.cal_dt_last_day_prev_1y     AS cal_dt_last_day_prev_1y,
   Cal.cal_dt_first_day_next_1w    AS cal_dt_first_day_next_1w,
   Cal.last_day_week_fg            AS last_day_week_fg,
   Cal.last_day_week_partial_fg    AS last_day_week_partial_fg,
   Cal.last_day_month_fg           AS last_day_month_fg,
   Cal.last_day_year_fg            AS last_day_year_fg,
   Cal.cy_day_seq                  AS cy_day_seq,
   Cal.cy_week_seq                 AS cy_week_seq,
   Cal.cy_month_seq                AS cy_month_seq,
   Cal.busyear_seq                 AS busyear_seq,
   Cal.dwh_load_id                 AS dwh_load_id,
   Cal.dwh_created                 AS dwh_created,
   Cal.dwh_updated                 AS dwh_updated
FROM p_lew_mart_analytics.v_cal_calendarday_2        AS Cal
   );