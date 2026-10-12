CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_CAL_DAY_PY_BUSINESS_YEAR_ADJUSTED_1
(
     cal_dt
,          bus_year_diff
,          incl_cal_dt
,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalDay.cal_dt           AS cal_dt,
   CalDay.bus_year_diff    AS bus_year_diff,
   CalDay.incl_cal_dt      AS incl_cal_dt,
   CalDay.dwh_load_id      AS dwh_load_id,
   CalDay.dwh_created      AS dwh_created,
   CalDay.dwh_updated      AS dwh_updated
FROM p_lew_bil_ac.v_cal_day_py_business_year_adjusted_1        AS CalDay
   );