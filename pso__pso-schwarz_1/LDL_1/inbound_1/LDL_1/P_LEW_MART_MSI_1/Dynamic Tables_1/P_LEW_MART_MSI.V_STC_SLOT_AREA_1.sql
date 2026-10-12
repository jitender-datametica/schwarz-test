
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STC_SLOT_AREA_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT wssa.client_id,  
   w.src_wh_id AS wh_id,   
   wssa.stc_slot_area,  
   wssa.dat_rec_start,  
   wssa.dat_rec_end, 
   wssa.stc_slot_id_from,  
   wssa.stc_slot_id_until, 
   wssa.stc_location_id,   
   wssa.allocation_info,   
   wssa.stc_location_nr_wamas,   
   wssa.qty_max_case,   
   wssa.qty_max_layer,  
   wssa.qty_max_dd,  
   wssa.qty_max_euro,   
   wssa.max_order_amount,  
   wssa.stc_slot_send_cd,  
   wssa.mde_print_cd,   
   wssa.wamas_group, 
   wssa.pallet_factor_avg, 
   wssa.pallet_target_height_go, 
   wssa.pallet_feet_height_go,   
   wssa.tour_active_cd, 
   wssa.tlb_serial_nr,  
   wssa.avg_mde_factor_active_cd,   
   wssa.factor_type, 
   wssa.factor_value,   
   wssa.weight_euro_avg,   
   wssa.weight_dd_avg,  
   wssa.weight_box_avg, 
   wssa.weight_tktrolli_avg,  
   wssa.weight_rolli_avg,  
   wssa.ssi_fg,   
   wssa.load_id   
  FROM p_lew_core_ac.v_wawi_stc_slot_area_1 AS wssa  
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS w  
   ON wssa.client_id = w.client_id  
   AND wssa.wh_loc_sid = w.loc_sid_wh  
   AND w.dwh_actual_fg = 1 
;
