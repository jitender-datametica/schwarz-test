CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_ADVERTISE_THEME_DELIVER_HIST_2
(
   client_id          
   ,mdm_ad_theme_sid   
   ,item_del_seq       
   ,cy_week_theme_del  
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
   ,mdm_ad_theme_sid   
   ,item_del_seq       
   ,cy_week_theme_del  
   ,deleted_fg         
   ,dwh_valid_from     
   ,dwh_valid_to       
   ,dwh_load_id        
   ,dwh_created        
   ,dwh_updated        
  FROM p_lew_core.T_MDM_ADVERTISE_THEME_DELIVER_HIST_2
;

     