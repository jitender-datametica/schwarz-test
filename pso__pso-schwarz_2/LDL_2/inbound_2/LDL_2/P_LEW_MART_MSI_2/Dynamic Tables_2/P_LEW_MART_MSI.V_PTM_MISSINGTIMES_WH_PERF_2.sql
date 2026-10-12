
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PTM_MISSINGTIMES_WH_PERF_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT   
   tim.client_id, 
   s2wh.src_wh_id AS wh_id,   
   tim.loc_sid_store AS store_id,   
   -999 AS missingtimes_id,   
   -999 AS mis_key,  
   -999 AS dat_modification,  
   -999 AS missingtype_id, 
   tim.dwh_cal_dt AS dat_working,   
   -999 AS dat_valid_from, 
   -999 AS dat_valid_until,   
   -999 AS time_missing_from, 
   -999 AS missing_from_fg,   
   -999 AS time_missing_until,   
   -999 AS missing_until_fg,  
   tim.perform_relev_absence_hr AS time_missing_period,  
   -999 AS val_missing, 
   -999 AS sap_export,  
   -999 AS backoffice_import, 
   -999 AS valid_for,   
   tim.dwh_cal_dt AS dat_dayend, 
   tim.dwh_load_id AS load_id 
   FROM p_lew_bil_ac.v_agg_work_time_store_day_2 AS tim 
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS s2wh 
   ON tim.client_id = s2wh.client_id   
   AND tim.loc_sid_store = s2wh.loc_sid_store   
   AND s2wh.dwh_actual_fg = 1 
   AND s2wh.active_fg = 1  
WHERE tim.perform_relev_absence_hr IS NOT NULL  
;
