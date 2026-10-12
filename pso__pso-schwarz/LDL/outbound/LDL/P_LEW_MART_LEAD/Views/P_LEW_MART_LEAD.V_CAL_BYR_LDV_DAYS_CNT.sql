/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_CAL_BYR_LDV_DAYS_CNT
#----------------------------------------------------------------------------
# History:
#  1.0  20.11.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cal_byr_ldv_days_cnt (dwh_cal_dt, cy_week, cy_month, busyear, ldv_days_cnt
) AS SELECT cal_dt AS dwh_cal_dt,
 cy_week,
 cy_month,
 busyear,
 CAST(COUNT(cal_dt) OVER (PARTITION BY CAST(busyear AS STRING) ORDER BY cal_dt IS NULL, cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS BIGNUMERIC)
 AS ldv_days_cnt
FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
WHERE cal_dt < CURRENT_DATE;