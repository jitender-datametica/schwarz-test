/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_CAL_BYR_LDV_DAYS_CNT_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.11.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_CAL_BYR_LDV_DAYS_CNT_2
(
 dwh_cal_dt
,cy_week
,cy_month
,busyear
,ldv_days_cnt
)AS
SELECT 
 dwh_cal_dt
,cy_week
,cy_month
,busyear
,ldv_days_cnt
FROM P_LEW_MART_LEAD.V_CAL_BYR_LDV_DAYS_CNT_2
;