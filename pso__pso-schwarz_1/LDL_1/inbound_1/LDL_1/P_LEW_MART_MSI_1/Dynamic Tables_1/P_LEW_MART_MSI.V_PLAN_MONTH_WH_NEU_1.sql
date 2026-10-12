
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_PLAN_MONTH_WH_NEU_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  24.01.2018    Wieber,Harald            Release 2.2.1
#  1.3  23.04.2021    Rekovsky, Marvin         20210422_2813_TransAll_Shutdown_Update(REP1-14416): Replace legacy object
#                                              v_wawi_cal_calendarday_1 with v_cal_calendarday_1
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PLAN_MONTH_WH_NEU_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT 
     pm.plan_id,  
   pm.indicator_id, 
   pm.client_id,  
   vlmk.wawi_dwh_wh_id AS wh_id,  
   pm.cy_month, 
   CASE WHEN pm.indicator_id IN (200,201,202,607,700,900) 
    THEN pm.val_plan_month  
    ELSE pm.val_plan_month / cry.rate_currency_exchange 
   END AS val_plan, 
   pm.pct_plan_month AS pct_plan, 
   pm.dat_dayend, 
   cry.currency_iso_cd, 
   pm.dat_valid_from, 
   pm.dat_valid_until,  
   cal.busyear, 
   SUM(val_plan) OVER (PARTITION BY pm.plan_id, pm.indicator_id, pm.client_id, pm.wh_loc_sid, cry.currency_iso_cd, cal.busyear  
                        ORDER BY pm.dat_valid_from ASC  
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS val_plan_cum 
  
  FROM p_lew_core_ac.v_wawi_plan_month_1 pm_1 
   INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS vlmk 
   ON vlmk.loc_sid =  pm.wh_loc_sid 
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal 
   ON pm.dat_valid_from = cal.cal_dt
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 cry 
   ON pm.client_id = cry.client_id  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
  
   WHERE pm.wh_loc_sid IS NOT NULL  
   AND pm.orig_store_nr IS NULL 
   AND cal.cy_day_seq <= 0  
;
