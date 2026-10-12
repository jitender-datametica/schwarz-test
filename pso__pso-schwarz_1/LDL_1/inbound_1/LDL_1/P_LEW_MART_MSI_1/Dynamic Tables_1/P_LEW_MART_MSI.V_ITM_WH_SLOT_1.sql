
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_WH_SLOT_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9119 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Inventur_1   
   #DescEnd#   
   */ 
   
   SELECT   
   itm.client_id, 
   wh.src_wh_id AS wh_id,  
   itm.item_sid AS item_id,   
   itm.wh_slot_case, 
   itm.wh_slot_pallet,  
   itm.wh_slot_dd,   
   itm.inv_case_fg,  
   itm.inv_euro_fg,  
   itm.inv_dd_fg  
   FROM p_lew_core_ac.v_wawi_itm_wh_slot_1 AS itm 
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh 
   ON wh.client_id = itm.client_id  
   AND wh.loc_sid_wh =  itm.wh_loc_sid 
   AND wh.dwh_actual_fg = 1   
   
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end 
;
