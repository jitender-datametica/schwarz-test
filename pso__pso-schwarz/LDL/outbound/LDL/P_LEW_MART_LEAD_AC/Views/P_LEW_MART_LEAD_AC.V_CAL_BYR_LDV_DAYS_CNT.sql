/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_CAL_BYR_LDV_DAYS_CNT
#----------------------------------------------------------------------------
# History:
#  1.0  20.11.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cal_byr_ldv_days_cnt (dwh_cal_dt, cy_week, cy_month, busyear,
ldv_days_cnt) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cal_byr_ldv_days_cnt;