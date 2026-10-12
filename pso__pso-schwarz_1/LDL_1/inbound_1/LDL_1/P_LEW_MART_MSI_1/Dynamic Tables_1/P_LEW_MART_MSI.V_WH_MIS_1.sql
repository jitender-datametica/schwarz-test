
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_WH_MIS_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT a.client_id,  
   b.src_wh_id AS wh_id 
  FROM p_lew_core_ac.v_wawi_org_wh_act_1 AS a  
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS b  
   ON a.client_id = b.client_id  
   AND a.wh_loc_sid = b.loc_sid_wh  
   AND b.dwh_actual_fg = 1 
   LEFT OUTER JOIN p_lew_process_ac.v_sap_migration_wh_1 AS migr_wh 
   ON a.client_id = migr_wh.client_id  
   AND a.wh_loc_sid = migr_wh.loc_sid_wh  
   AND CURRENT_DATE BETWEEN migr_wh.migrated_start_dt AND migr_wh.migrated_end_dt   
   LEFT OUTER JOIN p_lew_process_ac.v_sap_migration_client_1 AS migr_client  
   ON a.client_id = migr_client.client_id 
   AND CURRENT_DATE BETWEEN migr_client.migrated_start_dt AND migr_client.migrated_end_dt 
WHERE a.language_id = 7 
AND ( 
   -- WH ist nicht nach SAP (eLWIS) migriert und Client ist nicht nach SAP migriert 
   (migr_wh.client_id IS NULL AND migr_client.client_id IS NULL)  
   OR (COALESCE(a.ovis_data_fg, 0) = 1 AND COALESCE(a.wawi_data_fg, 0) = 0)   
)  
;
