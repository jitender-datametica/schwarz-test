create or replace view LDL_PRODUCTION.P_LEW_BIL_AC.V_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_2(
	CAL_DT,
	CY_WEEK_PART,
	BUS_YEAR_DIFF,
	INCL_CAL_DT,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   (
        SELECT      CalDay.cal_dt           AS cal_dt,
   CalDay.cy_week_part     AS cy_week_part,
   CalDay.bus_year_diff    AS bus_year_diff,
   CalDay.incl_cal_dt      AS incl_cal_dt,
   CalDay.dwh_load_id      AS dwh_load_id,
   CalDay.dwh_created      AS dwh_created,
   CalDay.dwh_updated      AS dwh_updated
FROM p_lew_bil.t_cal_day_py_swday_business_year_adjusted_2        AS CalDay
   );
