CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_DIM_CAL_WEEK_PARTIAL_2
(
     cy_week_part

,          cy
,          bus_year

,          cy_month
,          cy_week

,          week_of_year
,          week_part_seq

,          cy_week_part_begin_dt
,          cy_week_part_end_dt
,          cy_week_part_begin_day_of_week
,          cy_week_part_end_day_of_week

,          cy_week_part_full_week_fg
,          cy_week_part_day_cnt

,          cy_week_part_prev_1y
,          cy_week_part_prev_2y
,          cy_week_part_prev_3y
,          cy_week_part_prev_4y
,          cy_week_part_prev_5y

,          period_swday_prev_1y_begin_dt
,          period_swday_prev_1y_end_dt
,          period_swday_prev_2y_begin_dt
,          period_swday_prev_2y_end_dt
,          period_swday_prev_3y_begin_dt
,          period_swday_prev_3y_end_dt
,          period_swday_prev_4y_begin_dt
,          period_swday_prev_4y_end_dt
,          period_swday_prev_5y_begin_dt
,          period_swday_prev_5y_end_dt

,          cy_week_part_offset
,          cy_week_offset
,          cy_month_offset
,          cy_offset
,          bus_year_offset

,          cy_week_part_short_name
,          cy_week_part_name
,          cy_week_part_descr

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalPWk.cy_week_part                      AS cy_week_part,
   CalPWk.cy                                AS cy,
   CalPWk.bus_year                          AS bus_year,
   CalPWk.cy_month                          AS cy_month,
   CalPWk.cy_week                           AS cy_week,
   CalPWk.week_of_year                      AS week_of_year,
   CalPWk.week_part_seq                     AS week_part_seq,
   CalPWk.cy_week_part_begin_dt             AS cy_week_part_begin_dt,
   CalPWk.cy_week_part_end_dt               AS cy_week_part_end_dt,
   CalPWk.cy_week_part_begin_day_of_week    AS cy_week_part_begin_day_of_week,
   CalPWk.cy_week_part_end_day_of_week      AS cy_week_part_end_day_of_week,
   CalPWk.cy_week_part_full_week_fg         AS cy_week_part_full_week_fg,
   CalPWk.cy_week_part_day_cnt              AS cy_week_part_day_cnt,
   CalPWk.cy_week_part_prev_1y              AS cy_week_part_prev_1y,
   CalPWk.cy_week_part_prev_2y              AS cy_week_part_prev_2y,
   CalPWk.cy_week_part_prev_3y              AS cy_week_part_prev_3y,
   CalPWk.cy_week_part_prev_4y              AS cy_week_part_prev_4y,
   CalPWk.cy_week_part_prev_5y              AS cy_week_part_prev_5y,
   CalPWk.period_swday_prev_1y_begin_dt     AS period_swday_prev_1y_begin_dt,
   CalPWk.period_swday_prev_1y_end_dt       AS period_swday_prev_1y_end_dt,
   CalPWk.period_swday_prev_2y_begin_dt     AS period_swday_prev_2y_begin_dt,
   CalPWk.period_swday_prev_2y_end_dt       AS period_swday_prev_2y_end_dt,
   CalPWk.period_swday_prev_3y_begin_dt     AS period_swday_prev_3y_begin_dt,
   CalPWk.period_swday_prev_3y_end_dt       AS period_swday_prev_3y_end_dt,
   CalPWk.period_swday_prev_4y_begin_dt     AS period_swday_prev_4y_begin_dt,
   CalPWk.period_swday_prev_4y_end_dt       AS period_swday_prev_4y_end_dt,
   CalPWk.period_swday_prev_5y_begin_dt     AS period_swday_prev_5y_begin_dt,
   CalPWk.period_swday_prev_5y_end_dt       AS period_swday_prev_5y_end_dt,
   CalPWk.cy_week_part_offset               AS cy_week_part_offset,
   CalPWk.cy_week_offset                    AS cy_week_offset,
   CalPWk.cy_month_offset                   AS cy_month_offset,
   CalPWk.cy_offset                         AS cy_offset,
   CalPWk.bus_year_offset                   AS bus_year_offset,
   CalPWk.cy_week_part_short_name           AS cy_week_part_short_name,
   CalPWk.cy_week_part_name                 AS cy_week_part_name,
   CalPWk.cy_week_part_descr                AS cy_week_part_descr,
   CalPWk.dwh_load_id                       AS dwh_load_id,
   CalPWk.dwh_created                       AS dwh_created,
   CalPWk.dwh_updated                       AS dwh_updated

FROM p_lew_bil_ac.v_dim_cal_week_partial_2        AS CalPWk
   );