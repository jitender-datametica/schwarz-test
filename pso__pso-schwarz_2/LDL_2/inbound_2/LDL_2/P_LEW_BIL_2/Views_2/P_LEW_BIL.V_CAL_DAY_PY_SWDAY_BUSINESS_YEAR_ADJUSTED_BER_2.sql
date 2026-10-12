create or replace view LDL_PRODUCTION.P_LEW_BIL.V_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_BER_2(
	CAL_DT,
	CY_WEEK_PART,
	PREV_CY_DAT_CALENDAR_SWD_BER,
	PREV_PREV_CY_DAT_CALENDAR_SWD_BER,
	PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER,
	PREV_CY_DAT_CALENDAR_SWD_BER_CUM,
	PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM,
	PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
) as
SELECT 
    dcd.CAL_DT AS CAL_DT
    ,dcd.CY_WEEK_PART AS CY_WEEK_PART
    ,dcd.CAL_DT_SWDAY_PREV_1Y AS PREV_CY_DAT_CALENDAR_SWD_BER
    ,dcd.CAL_DT_SWDAY_PREV_2Y AS PREV_PREV_CY_DAT_CALENDAR_SWD_BER
    ,dcd.CAL_DT_SWDAY_PREV_3Y AS PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER
    ,CASE WHEN MOD(dcd.cy,4) = 0 AND TO_CHAR(dcd.cal_dt,'YYYY-MM_2-DD') LIKE '%02-29' THEN DATEADD(DAY,-2, dcd.CAL_DT_SWDAY_PREV_2Y) ELSE adj1.incl_cal_dt END AS PREV_CY_DAT_CALENDAR_SWD_BER_CUM
    ,CASE WHEN MOD(dcd.cy,4) = 0 AND TO_CHAR(dcd.cal_dt,'YYYY-MM_2-DD') LIKE '%02-29' THEN DATEADD(DAY,-2, dcd.CAL_DT_SWDAY_PREV_3Y) ELSE adj2.incl_cal_dt END AS PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
    ,CASE WHEN MOD(dcd.cy,4) = 0 AND TO_CHAR(dcd.cal_dt,'YYYY-MM_2-DD') LIKE '%02-29' THEN DATEADD(DAY,-2, dcd.CAL_DT_SWDAY_PREV_4Y) ELSE adj3.incl_cal_dt END AS PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM
FROM P_LEW_BIL_AC.V_DIM_CAL_DAY_2 dcd
LEFT JOIN p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_2 adj1
 ON dcd.CAL_DT = adj1.CAL_DT
 AND adj1.bus_year_diff = 1
LEFT JOIN p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_2 adj2
 ON dcd.CAL_DT = adj2.CAL_DT
 AND adj2.bus_year_diff = 2
LEFT JOIN p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_2 adj3
 ON dcd.CAL_DT = adj3.CAL_DT
 AND adj3.bus_year_diff = 3
/*QUAFILY so there are no duplicates in cal_dt and non _CUM columns (the way it was bfore B-0011292A-AP0120280 change). 
Rmoval of it will lead to correct solution, but major cross impact. It was decided to do it like this for at least some time*/
QUALIFY ROW_NUMBER() OVER (PARTITION BY dcd.CAL_DT ORDER BY PREV_CY_DAT_CALENDAR_SWD_BER_CUM, PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM,PREV_PREV_PREV_CY_DAT_CALENDAR_SWD_BER_CUM  ) = 1
 ;
