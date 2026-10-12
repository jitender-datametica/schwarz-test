
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_CLIENT_LANGUAGE 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Language_views   
   #DescEnd#   
   */ 
   SELECT   
   client_id,  
   language_id FROM p_lew_core_ac.v_wawi_ref_client_language   
   UNION 
   SELECT   
   client_id,  
   7 AS language_id  
   FROM p_lew_core_ac.v_wawi_ref_client_language   
;
