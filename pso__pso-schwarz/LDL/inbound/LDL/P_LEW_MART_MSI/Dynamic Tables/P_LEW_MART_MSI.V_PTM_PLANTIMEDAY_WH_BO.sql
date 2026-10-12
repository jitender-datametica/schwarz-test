
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PTM_PLANTIMEDAY_WH_BO 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT   
   c.cy_week - (c.cy * 100)      AS cal_week,   
   ptm.client_id                 AS client_id,  
   ptm.dwh_created               AS dat_creation,  
   ptm.dwh_created               AS dat_dayend, 
   ptm.plan_update_tmsp          AS dat_last_update,  
   ptm.cal_dt                    AS dat_plantime,  
   ptm.dwh_load_id               AS load_id, 
   NULL                          AS plantimeday_desc, 
   0                             AS release_fg, 
   ptm.loc_sid_store             AS store_id,   
   0                             AS val_holidays,  
   ptm.hours_total_cnt           AS val_hours,  
   ptm.hours_inventory_cnt       AS val_inventory, 
   ptm.turnover_per_hour_net_val AS val_performance,  
   ptm.hours_training_cnt        AS val_training,  
   ptm.turnover_net_val          AS val_turnover,  
   0                             AS val_workingdays,  
   w.loc_sid_wh                  AS wh_id 
   
   FROM p_lew_core_ac.v_workingtime_plan_store_day ptm   
   INNER JOIN p_lew_core_ac.v_cal_calendarday c 
   ON ptm.cal_dt = c.cal_dt   
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse w  
   ON  ptm.client_id     = w.client_id 
   AND ptm.loc_sid_store = w.loc_sid_store   
;
