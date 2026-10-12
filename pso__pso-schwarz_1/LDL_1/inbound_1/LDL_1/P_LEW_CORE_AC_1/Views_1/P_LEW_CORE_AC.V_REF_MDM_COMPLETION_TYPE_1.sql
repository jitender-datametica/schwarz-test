CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_COMPLETION_TYPE_1
(
   market_sid                  
   ,mdm_completion_type_cd      
   ,mdm_completion_type_name   
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated      
)
AS
   SELECT
   market_sid                  
   ,mdm_completion_type_cd      
   ,mdm_completion_type_name   
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated            
  FROM p_lew_core.T_REF_MDM_COMPLETION_TYPE_1
;