
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PLAN_WEEK_WH_NEU_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 6761 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Planungswerte 
   #DescEnd#   
   */ 
   SELECT   
     pm.plan_id,  
   pm.indicator_id,  
   pm.client_id,  
   vlmk.wawi_dwh_wh_id AS wh_id, 
   pm.cy_week, 
   CASE WHEN pm.indicator_id IN (200,201,202,607,700,900)   
      THEN pm.val_plan_week   
      ELSE pm.val_plan_week / cry.rate_currency_exchange 
   END AS val_plan,  
   pm.pct_plan_week AS pct_plan, 
   pm.dat_dayend, 
   cry.currency_iso_cd, 
   pm.dat_valid_from,   
   pm.dat_valid_until,  
   cal.busyear,   
   SUM(val_plan) OVER (PARTITION BY pm.plan_id, pm.indicator_id, pm.client_id, pm.wh_loc_sid, cry.currency_iso_cd, cal.busyear   
          ORDER BY pm.dat_valid_from ASC  
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS val_plan_cum1, 
   RANK() OVER (PARTITION BY pm.plan_id, pm.indicator_id, pm.client_id, pm.wh_loc_sid, pm.cy_week, cry.currency_iso_cd  
          ORDER BY cal.busyear DESC NULLS LAST) AS val_plan_cum_rank,   
   CASE WHEN val_plan_cum_rank = 1  
      THEN val_plan_cum1   
      ELSE NULL   
      END AS val_plan_cum, 
   CASE WHEN val_plan_cum_rank = 1  
      THEN val_plan  
      ELSE NULL   
      END AS val_plan1   --zu verwenden für die Berechnung aufgelaufener Werte. Siehe OP 160788.   
   
  FROM p_lew_core_ac.v_wawi_plan_week_1 pm_1  
   INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS vlmk  
   ON vlmk.loc_sid =  pm.wh_loc_sid 
   INNER JOIN p_lew_core_ac.v_wawi_cal_calendarday_1 cal   
   ON pm.dat_valid_from = cal.dat_calendar   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 cry   
   ON pm.client_id = cry.client_id  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
   
   WHERE pm.wh_loc_sid IS NOT NULL  
   AND pm.orig_store_nr IS NULL  
   AND cal.cy_day_sequence <= 0  
;
