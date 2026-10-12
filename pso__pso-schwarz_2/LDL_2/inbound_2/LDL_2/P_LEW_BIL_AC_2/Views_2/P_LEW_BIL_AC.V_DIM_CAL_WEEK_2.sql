CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_DIM_CAL_WEEK_2
(
     cy_week

--,        iso_year                   
,          week_of_year

,          cy_week_begin_week_part
,          cy_week_end_week_part
,          cy_week_begin_dt
,          cy_week_end_dt

,          cy_week_week_part_cnt

,          cy_week_prev_1w
,          cy_week_prev_1y
,          cy_week_prev_2y
,          cy_week_prev_3y
,          cy_week_prev_4y
,          cy_week_prev_5y

,          cy_week_offset
--,        iso_year_offset             

,          cy_week_short_name
,          cy_week_name

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalWk.cy_week                    AS cy_week,
   CalWk.week_of_year               AS week_of_year,
   CalWk.cy_week_begin_week_part    AS cy_week_begin_week_part,
   CalWk.cy_week_end_week_part      AS cy_week_end_week_part,
   CalWk.cy_week_begin_dt           AS cy_week_begin_dt,
   CalWk.cy_week_end_dt             AS cy_week_end_dt,
   CalWk.cy_week_week_part_cnt      AS cy_week_week_part_cnt,
   CalWk.cy_week_prev_1w            AS cy_week_prev_1w,
   CalWk.cy_week_prev_1y            AS cy_week_prev_1y,
   CalWk.cy_week_prev_2y            AS cy_week_prev_2y,
   CalWk.cy_week_prev_3y            AS cy_week_prev_3y,
   CalWk.cy_week_prev_4y            AS cy_week_prev_4y,
   CalWk.cy_week_prev_5y            AS cy_week_prev_5y,
   CalWk.cy_week_offset             AS cy_week_offset,
   CalWk.cy_week_short_name         AS cy_week_short_name,
   CalWk.cy_week_name               AS cy_week_name,
   CalWk.dwh_load_id                AS dwh_load_id,
   CalWk.dwh_created                AS dwh_created,
   CalWk.dwh_updated                AS dwh_updated

FROM p_lew_bil.t_dim_cal_week_2        AS CalWk
   );