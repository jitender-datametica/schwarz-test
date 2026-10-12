CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_2
(
     cal_dt
,          cy_week_part
,          bus_year_diff
,          incl_cal_dt
,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalDay.cal_dt           AS cal_dt,
   CalDay.cy_week_part     AS cy_week_part,
   CalDay.bus_year_diff    AS bus_year_diff,
   CalDay.incl_cal_dt      AS incl_cal_dt,
   CalDay.dwh_load_id      AS dwh_load_id,
   CalDay.dwh_created      AS dwh_created,
   CalDay.dwh_updated      AS dwh_updated
FROM p_lew_mart_lead.v_cal_day_py_swday_business_year_adjusted_2        AS CalDay
   );