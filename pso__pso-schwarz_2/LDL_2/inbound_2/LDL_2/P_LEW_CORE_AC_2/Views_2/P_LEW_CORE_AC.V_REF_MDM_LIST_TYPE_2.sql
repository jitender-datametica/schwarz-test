CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_LIST_TYPE_2
(               
   mdm_list_type_cd      
   ,mdm_list_type_name   
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated      
)
AS
   SELECT                
   mdm_list_type_cd      
   ,mdm_list_type_name   
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated            
  FROM p_lew_core.T_REF_MDM_LIST_TYPE_2
;