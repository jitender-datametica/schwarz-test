
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PLAN_YEAR_CLIENT_ITEMGROUP_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      /*    
      #DescStart#       
      #$Revision: 6244 $, $LastChangedBy: hwieber $   
      #SubjectAreas#: Planungswerte       
      #DescEnd#   
      */    
      SELECT      
      pm.plan_id, 
      pm.indicator_id,  
      pm.client_id,     
      pm.itemgroup_int_id,    
      pm.cy,      
      CASE WHEN pm.indicator_id IN (200,201,202,607,700,900) THEN pm.val_plan_year  ELSE pm.val_plan_year / cry.rate_currency_exchange END AS val_plan,     
      pm.pct_plan_year AS pct_plan, 
      pm.dat_dayend,    
      cry.currency_iso_cd     
      
       FROM p_lew_core_ac.v_wawi_plan_year_1 pm_1   
      INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry   
      ON  pm.client_id = cry.client_id    
      AND  CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end   
      
      WHERE pm.wh_loc_sid IS NULL   
      AND pm.orig_store_nr IS NULL  
      AND pm.itemgroup_int_id IS NOT NULL;
