CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_CAL_CALENDAR_YEAR
(
     cy

,          cy_begin_month
,          cy_end_month
,          cy_begin_week_part
,          cy_end_week_part
,          cy_begin_dt
,          cy_end_dt

,          cy_week_cnt
,          cy_week_part_cnt
,          cy_day_cnt

,          cy_prev_1y
,          cy_prev_2y
,          cy_prev_3y
,          cy_prev_4y
,          cy_prev_5y

,          cy_offset

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalCY.cy                    AS cy,
   CalCY.cy_begin_month        AS cy_begin_month,
   CalCY.cy_end_month          AS cy_end_month,
   CalCY.cy_begin_week_part    AS cy_begin_week_part,
   CalCY.cy_end_week_part      AS cy_end_week_part,
   CalCY.cy_begin_dt           AS cy_begin_dt,
   CalCY.cy_end_dt             AS cy_end_dt,
   CalCY.cy_week_cnt           AS cy_week_cnt,
   CalCY.cy_week_part_cnt      AS cy_week_part_cnt,
   CalCY.cy_day_cnt            AS cy_day_cnt,
   CalCY.cy_prev_1y            AS cy_prev_1y,
   CalCY.cy_prev_2y            AS cy_prev_2y,
   CalCY.cy_prev_3y            AS cy_prev_3y,
   CalCY.cy_prev_4y            AS cy_prev_4y,
   CalCY.cy_prev_5y            AS cy_prev_5y,
   CalCY.cy_offset             AS cy_offset,
   CalCY.dwh_load_id           AS dwh_load_id,
   CalCY.dwh_created           AS dwh_created,
   CalCY.dwh_updated           AS dwh_updated

FROM p_lew_mart_lead.v_dim_cal_calendar_year        AS CalCY
   );