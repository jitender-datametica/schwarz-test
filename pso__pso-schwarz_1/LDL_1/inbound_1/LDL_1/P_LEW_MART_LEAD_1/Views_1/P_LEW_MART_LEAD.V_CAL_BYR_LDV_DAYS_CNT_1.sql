/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_CAL_BYR_LDV_DAYS_CNT_1
#----------------------------------------------------------------------------
# History:
#  1.0  20.11.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_CAL_BYR_LDV_DAYS_CNT_1
(
 dwh_cal_dt
,cy_week
,cy_month
,busyear
,ldv_days_cnt
)AS
SELECT 
 cal.cal_dt AS dwh_cal_dt
,cal.cy_week
,cal.cy_month
,cal.busyear
,(COUNT(cal_dt) 
     OVER(PARTITION BY  cal.busyear
              ORDER BY cal.cal_dt ROWS UNBOUNDED PRECEDING))::NUMBER(18,0) AS ldv_days_cnt
FROM p_lew_core_ac.v_cal_calendarday_1 cal
WHERE cal.cal_dt<CURRENT_DATE
;