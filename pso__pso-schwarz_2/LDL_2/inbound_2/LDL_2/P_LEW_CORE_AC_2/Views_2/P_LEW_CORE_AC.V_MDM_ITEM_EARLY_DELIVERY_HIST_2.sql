CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ITEM_EARLY_DELIVERY_HIST_2
(
       client_id               
       ,mdm_item_sid            
       ,item_early_del_seq      
       ,cy_week_item_early_del  
       ,dwh_valid_from          
       ,dwh_valid_to            
       ,deleted_fg              
       ,dwh_load_id             
       ,dwh_created             
       ,dwh_updated        
)
AS
   SELECT
       client_id               
       ,mdm_item_sid            
       ,item_early_del_seq      
       ,cy_week_item_early_del  
       ,dwh_valid_from          
       ,dwh_valid_to            
       ,deleted_fg              
       ,dwh_load_id             
       ,dwh_created             
       ,dwh_updated         
  FROM p_lew_core.T_MDM_ITEM_EARLY_DELIVERY_HIST_2
;

           