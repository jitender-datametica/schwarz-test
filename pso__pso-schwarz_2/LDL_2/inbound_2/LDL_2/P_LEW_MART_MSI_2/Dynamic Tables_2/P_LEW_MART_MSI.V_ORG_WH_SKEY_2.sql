
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_WH_SKEY_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      SELECT DISTINCT   
            wh_skey.client_id,      
      gl_region_id,     
      wh.src_wh_id AS wh_id,  
      aspect_id   
     FROM p_lew_core_ac.v_wawi_org_wh_skey_2 wh_skey    
      INNER JOIN p_lew_bil_ac.v_warehouse_2 wh    
      ON wh_skey.wh_loc_sid = wh.loc_sid_wh     
      AND wh_skey.client_id = wh.client_id      
      AND wh.dwh_actual_fg = 1;
