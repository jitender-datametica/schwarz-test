CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_ITEM_COMPOSITION
(
   mdm_item_composition_cd                  
   ,mdm_item_composition_txt         
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated      
)
AS
   SELECT
   mdm_item_composition_cd                  
   ,mdm_item_composition_txt   
   ,dwh_load_id                 
   ,dwh_created                 
   ,dwh_updated            
  FROM p_lew_core.T_REF_MDM_ITEM_COMPOSITION
;