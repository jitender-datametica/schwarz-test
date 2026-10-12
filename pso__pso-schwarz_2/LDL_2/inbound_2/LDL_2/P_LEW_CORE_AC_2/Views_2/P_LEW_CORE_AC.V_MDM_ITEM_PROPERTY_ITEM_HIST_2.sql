CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_PROPERTY_ITEM_HIST_2
(
  client_id              
  ,mdm_item_sid           
  ,mdm_item_property_txt
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
  ,mdm_item_sid           
  ,mdm_item_property_txt
  ,deleted_fg             
  ,dwh_valid_from         
  ,dwh_valid_to           
  ,dwh_load_id            
  ,dwh_created            
  ,dwh_updated          
  FROM p_lew_core.T_MDM_ITEM_PROPERTY_ITEM_HIST_2
;



         