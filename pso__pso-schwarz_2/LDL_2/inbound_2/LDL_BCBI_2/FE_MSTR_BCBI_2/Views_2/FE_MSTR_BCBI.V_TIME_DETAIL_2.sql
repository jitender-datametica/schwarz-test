CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TIME_DETAIL_2 AS
SELECT ex.CLIENT_ID
,ex.COUNTRY_ISO
,ex.WH_ID
,ex.LOC_SID_WH
,ex.WH_DESC
,ex.WH_TYPE
,ex.LOC_SID_STORE
,ex.ORIG_STORE_NR
,ex.STORE_DESC
,ex.DAT_OPEN
,calweek.WEEK_OF_YEAR AS WEEK
,calweek.cy_week_shORt_name AS WEEK_NAME
,calweek.cy_week AS WEEK_ID
,calday.month_of_year AS MONTH
,calday.month_of_year_name AS MONTH_NAME
,calday.cy_month AS MONTH_ID
,calday.cy AS YEAR
,main.WORK_TIME_GROSS_HR  
,main.WORK_TIME_NET_HR
,main.BREAK_HR
,main.PERFORM_RELEV_ABSENCE_HR
,ex.SOURCE_SYSTEM
,plan.HOURS_TOTAL_CNT AS PLAN_HOURS_TOTAL_CNT
,plan.HOURS_WORKING_CNT AS PLAN_HOURS_WORKING_CNT
,main.WORK_TIME_NET_HR-PLAN_HOURS_TOTAL_CNT   AS diff_hour
,CASE WHEN plan.HOURS_TOTAL_CNT = 0 OR PLAN_HOURS_TOTAL_CNT IS NULL THEN 0 ELSE 1-( main.WORK_TIME_NET_HR/PLAN_HOURS_TOTAL_CNT) END AS diff_hour_perc
,CASE WHEN WORK_TIME_NET_HR IS Null THEN 1 ELSE 0 END AS mISsing_fg
,CASE WHEN MISSING_FG = 1 THEN 'Fehlt' ELSE 'Erhalten' END AS mISsing_desc
,ROUND(abf.abverkauf,0) AS ABVERKAUF
FROM FE_MSTR_BCBI.V_TIME_STORE_EXPECTED_LIST_2 ex 
LEFT JOIN FE_MSTR_BCBI.V_TIME_MAIN_2 AS main
ON ex.client_id  = main.client_id
AND ex.loc_sid_stORe = main.loc_sid_stORe
AND ex.dat_open = main.dwh_cal_dt
LEFT JOIN FE_MSTR_BCBI.T_TIME_ABVERKAUF_2 AS abf 
ON ex.client_id = abf.client_id
AND ex.loc_sid_stORe = abf.loc_sid
AND ex.dat_open = abf.dwh_cal_dt
LEFT JOIN FE_MSTR_BCBI.T_WORKINGTIME_PLAN_STORE_DAY_2 AS plan
ON ex.client_id = plan.client_id
AND ex.loc_sid_store=plan.loc_sid_store
AND ex.dat_open=plan.cal_dt
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_DAY_2 AS calday ON ex.DAT_OPEN = calday.cal_dt
LEFT JOIN FE_MSTR_BCBI.T_DIM_CAL_WEEK_2 AS calweek ON calday.cy_week = calweek.cy_week
;