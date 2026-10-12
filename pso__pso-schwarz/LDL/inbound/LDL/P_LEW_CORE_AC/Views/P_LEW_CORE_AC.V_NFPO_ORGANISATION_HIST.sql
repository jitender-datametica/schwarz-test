CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_NFPO_ORGANISATION_HIST
(
   client_id       
   ,int_org_sid     
   ,display_seq     
   ,active_fg       
   ,deleted_fg      
   ,dwh_valid_from  
   ,dwh_valid_to    
   ,dwh_load_id     
   ,dwh_created     
   ,dwh_updated      
)
AS
   SELECT
   client_id       
   ,int_org_sid     
   ,display_seq     
   ,active_fg       
   ,deleted_fg      
   ,dwh_valid_from  
   ,dwh_valid_to    
   ,dwh_load_id     
   ,dwh_created     
   ,dwh_updated           
  FROM p_lew_core.T_NFPO_ORGANISATION_HIST
;


            