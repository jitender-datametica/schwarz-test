
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_WH_ORDERINFORMATION 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9117 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Artikelstamm  
   #DescEnd#   
   */ 
   SELECT   
   a.client_id,   
   wh.src_wh_id AS wh_id,  
   a.dat_rec_end, 
   a.dat_rec_start,  
   a.delivery_time,  
   a.automatic_order_fg,   
   a.best_before_fg, 
   a.direct_delivery_fg,   
   a.dispo_add_information,   
   a.dispo_cd, 
   a.dispo_group_id, 
   a.dispo_period,   
   a.dispo_unit_id,  
   a.item_sid AS item_id,  
   a.min_order_week, 
   a.order_item_fg,  
   a.pallet_note, 
   a.weight,   
   a.weight_fg,   
   a.load_id   
  FROM p_lew_core_ac.v_wawi_itm_wh_orderinformation AS a 
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh 
   ON wh.client_id = a.client_id 
   AND wh.loc_sid_wh = a.wh_loc_sid 
   AND wh.dwh_actual_fg = 1   
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end 
;
