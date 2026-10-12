
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_AVAILABILITY_DAY_WH 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: KPGES Views   
   #DescEnd#   
   */ 
   SELECT   
   kpges.client_id,  
   wh.wh_id,   
   wh.aspect_id,  
   kpges.dat_calendar,  
   kpges.indicator_id,  
   kpges.availability_fg   
   FROM p_lew_mart_msi.v_kpges_availability_day kpges 
   INNER JOIN p_lew_mart_msi.v_org_wh_merge wh  
   ON  kpges.client_id=wh.client_id;
