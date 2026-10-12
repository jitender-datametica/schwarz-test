
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PLAN_MONTH_CLIENT_WH_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT 
     pm.plan_id,  
   pm.indicator_id, 
   pm.client_id,  
   wh.src_wh_id AS wh_id, 
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
   SUM(val_plan) Over (PARTITION BY pm.plan_id, pm.indicator_id, pm.client_id, c.wh_loc_sid, cry.currency_iso_cd, cal.busyear 
                        ORDER BY pm.dat_valid_from ASC  
                        ROWS BETWEEN Unbounded Preceding AND CURRENT ROW) AS val_plan_cum 
  FROM p_lew_core_ac.v_wawi_plan_month_1 pm_1 
   INNER JOIN p_lew_core_ac.v_wawi_cal_calendarday_1 cal  
   ON pm.dat_valid_from = cal.dat_calendar  
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_act_1 c 
   ON pm.client_id = c.client_id  
   AND c.language_id = 7  
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh  
   ON c.client_id = wh.client_id  
   AND c.wh_loc_sid = wh.loc_sid_wh 
   AND wh.dwh_actual_fg = 1 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 cry 
   ON pm.client_id = cry.client_id  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
  
   WHERE pm.wh_loc_sid IS NULL  
     AND pm.orig_store_nr IS NULL 
     AND pm.itemgroup_int_id IS NULL  
     AND cal.cy_day_sequence <= 0 
;
