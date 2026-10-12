
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_WH_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
         /* 
         #DescStart#    
         #$Revision: 6699 $, $LastChangedBy: hwieber $  
         #SubjectAreas#: Artikelstamm   
         #DescEnd#  
         */ 
         SELECT 
         a.client_id,   
         f.src_wh_id AS wh_id,  
         a.item_sid AS item_id, 
         b.pallet_factor_dus AS case_factor_dd, 
         b.pallet_factor AS case_factor_euro,   
         e.case_factor_layer,   
         e.case_size_dec,   
         e.dir_delete_fg,   
         e.forwarding_item_nr,  
         e.fresh_control_fg,    
         COALESCE(r.mis_itm_state_id, item_status) AS status_id,    
         e.item_status_reason,  
         e.item_status_updated_by,  
         e.min_orderunit,   
         e.min_case_dd_wh,  
         e.min_case_euro_wh,    
         e.min_case_wh, 
         e.min_case_layer_wh,   
         e.order_area_cd,   
         e.pallet_target_height_go, 
         e.pallet_feet_height_go,   
         e.pallet_factor_go,    
         e.poster_fg,   
         e.price_sign_fg,   
         e.price_strip_fg,  
         e.min_orderunit_desc,  
         e.min_orderunit_short_desc,    
         e.superstructure_item_fg,  
         e.timestamp_status_updated 
         FROM p_lew_bil_ac.v_item_2 AS a  
         INNER JOIN p_lew_core_ac.v_item_info_per_location_hist_2 AS b    
         ON b.client_id = a.client_id   
         AND b.item_sid = a.item_sid    
         AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to   
         AND b.deleted_fg = 0   
         INNER JOIN p_lew_bil_ac.v_warehouse_2 AS f   
         ON f.client_id=a.client_id 
         AND f.loc_sid_wh = b.loc_sid   
         AND f.dwh_actual_fg = 1    
         AND f.deleted_fg = 0   
         AND f.bges_active_fg = 1   
         LEFT JOIN p_lew_core_ac.v_map_mis_item_status_2 AS r 
         ON r.client_id = b.client_id   
         AND r.item_status_cd = b.item_status_cd    
         LEFT JOIN p_lew_core_ac.v_wawi_itm_item_wh_2 AS e    
         ON b.client_id = e.client_id   
         AND b.item_sid = e.item_sid    
         AND b.loc_sid = e.wh_loc_sid   
         AND CURRENT_DATE BETWEEN e.dat_rec_start AND e.dat_rec_end 
     WHERE  a.dwh_actual_fg = 1 
;
