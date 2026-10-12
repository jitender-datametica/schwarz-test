
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_WH_ORDERINFORMATION_HIST_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9118 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Kleinbelege / Storeforms  
   #DescEnd#   
   */ 
   SELECT   
      o.client_id,   
   wh.src_wh_id AS wh_id /*Gesellschaft*/,   
   o.item_sid AS item_id,  
   o.dat_rec_end, 
   o.dat_rec_start,  
   o.dispo_unit_id,  
   o.dispo_group_id, 
   o.weight,   
   o.weight_fg,   
   o.delivery_time,  
   o.min_order_week, 
   o.order_item_fg,  
   o.dispo_cd, 
   o.dispo_period,   
   o.dispo_add_information,   
   o.best_before_fg, 
   o.pallet_note, 
   o.automatic_order_fg,   
   o.direct_delivery_fg,   
   o.load_id   
   FROM p_lew_core_ac.v_wawi_itm_wh_orderinformation_2 AS o   
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh 
   ON wh.client_id = o.client_id 
   AND wh.loc_sid_wh = o.wh_loc_sid 
   AND wh.dwh_actual_fg = 1   
;
