CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_CAL_BUSINESS_YEAR_1
(
     bus_year

,          bus_year_begin_month
,          bus_year_end_month
,          bus_year_begin_week_part
,          bus_year_end_week_part
,          bus_year_begin_dt
,          bus_year_end_dt

,          bus_year_week_cnt
,          bus_year_week_part_cnt
,          bus_year_day_cnt

,          bus_year_prev_1y
,          bus_year_prev_2y
,          bus_year_prev_3y
,          bus_year_prev_4y
,          bus_year_prev_5y

,          bus_year_offset

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalBY.bus_year                    AS bus_year,
   CalBY.bus_year_begin_month        AS bus_year_begin_month,
   CalBY.bus_year_end_month          AS bus_year_end_month,
   CalBY.bus_year_begin_week_part    AS bus_year_begin_week_part,
   CalBY.bus_year_end_week_part      AS bus_year_end_week_part,
   CalBY.bus_year_begin_dt           AS bus_year_begin_dt,
   CalBY.bus_year_end_dt             AS bus_year_end_dt,
   CalBY.bus_year_week_cnt           AS bus_year_week_cnt,
   CalBY.bus_year_week_part_cnt      AS bus_year_week_part_cnt,
   CalBY.bus_year_day_cnt            AS bus_year_day_cnt,
   CalBY.bus_year_prev_1y            AS bus_year_prev_1y,
   CalBY.bus_year_prev_2y            AS bus_year_prev_2y,
   CalBY.bus_year_prev_3y            AS bus_year_prev_3y,
   CalBY.bus_year_prev_4y            AS bus_year_prev_4y,
   CalBY.bus_year_prev_5y            AS bus_year_prev_5y,
   CalBY.bus_year_offset             AS bus_year_offset,
   CalBY.dwh_load_id                 AS dwh_load_id,
   CalBY.dwh_created                 AS dwh_created,
   CalBY.dwh_updated                 AS dwh_updated

FROM p_lew_mart_lead.v_dim_cal_business_year_1        AS CalBY
   );