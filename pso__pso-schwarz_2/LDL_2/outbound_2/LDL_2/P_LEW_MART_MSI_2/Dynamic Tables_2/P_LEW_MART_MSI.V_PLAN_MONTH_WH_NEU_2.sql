/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_PLAN_MONTH_WH_NEU_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  24.01.2018    Wieber,Harald            Release 2.2.1
#  1.3  23.04.2021    Rekovsky, Marvin         20210422_2813_TransAll_Shutdown_Update(REP1-14416): Replace legacy object
#                                              v_wawi_cal_calendarday_2 with v_cal_calendarday_2
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_plan_month_wh_neu_2 AS
SELECT PM.plan_id,
 PM.indicator_id,
 PM.client_id,
 VLMK.wawi_dwh_wh_id AS wh_id,
 PM.cy_month,
  CASE
  WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
  THEN PM.val_plan_month
  ELSE PM.val_plan_month / CRY.rate_currency_exchange
  END AS val_plan,
 PM.pct_plan_month AS pct_plan,
 PM.dat_dayend,
 CRY.currency_iso_cd,
 PM.dat_valid_from,
 PM.dat_valid_until,
 CAL.busyear,
 SUM(CASE
   WHEN PM.indicator_id IN (200, 201, 202, 607, 700, 900)
   THEN PM.val_plan_month
   ELSE PM.val_plan_month / CRY.rate_currency_exchange
   END) OVER (PARTITION BY CAST(PM.plan_id AS STRING), CAST(PM.indicator_id AS STRING), CAST(PM.client_id AS STRING), CAST(PM.wh_loc_sid AS STRING)
    , CRY.currency_iso_cd, CAST(CAL.busyear AS STRING) ORDER BY PM.dat_valid_from IS NULL, PM.dat_valid_from
  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS val_plan_cum
FROM ldl_p_lew_core_ac.v_wawi_plan_month_2 AS PM_2
 INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_2 AS VLMK ON PM.wh_loc_sid = VLMK.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON PM.dat_valid_from = CAL.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON PM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
WHERE PM.wh_loc_sid IS NOT NULL
 AND PM.orig_store_nr IS NULL
 AND CAL.cy_day_seq <= 0;