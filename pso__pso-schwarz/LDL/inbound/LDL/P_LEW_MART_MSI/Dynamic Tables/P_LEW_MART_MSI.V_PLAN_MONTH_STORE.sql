
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PLAN_MONTH_STORE 

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
   osk.st_loc_sid AS store_id,   
   pm.cy_month,   
   CASE WHEN pm.indicator_id IN (200,201,202,607,700,900) THEN pm.val_plan_month ELSE pm.val_plan_month / cry.rate_currency_exchange END AS val_plan, 
   pm.pct_plan_month AS pct_plan,   
   pm.dat_dayend, 
   cry.currency_iso_cd  
   
    FROM p_lew_core_ac.v_wawi_plan_month pm  
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey osk 
   ON  osk.client_id = pm.client_id 
   AND  osk.orig_store_nr = pm.orig_store_nr 
   AND  CURRENT_DATE BETWEEN osk.dat_rec_start AND osk.dat_rec_end   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON  pm.client_id = cry.client_id 
   AND  CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end   
   
   WHERE pm.orig_store_nr IS NOT NULL;
