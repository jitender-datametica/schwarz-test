CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_CASE_COMPOSITION_1
(
   mdm_case_composition_cd                  
   ,mdm_case_composition_txt
   ,subcase_size_qty    
   ,mdm_case_composition_name     
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated      
)
AS
   SELECT
   mdm_case_composition_cd                  
   ,mdm_case_composition_txt 
   ,subcase_size_qty
   ,mdm_case_composition_name
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated            
  FROM p_lew_core.T_REF_MDM_CASE_COMPOSITION_1
;