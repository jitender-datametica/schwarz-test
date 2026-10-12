
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_SUP_WH_DATA_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9116 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Artikelstamm  
   #DescEnd#   
   */ 
   SELECT   
   sup.client_id, 
   sup.sup_sid AS supplier_id,   
   sup.item_sid AS item_id,   
   wh.src_wh_id AS wh_id,  
   sup.dat_rec_start,   
   sup.dat_rec_end,  
   sup.currency_nr,  
   sup.delivery_item_cd,   
   sup.dat_valid_from,  
   sup.dat_valid_until, 
   sup.active_fg, 
   sup.delete_fg, 
   sup.dur_shelflife_cust, 
   sup.period_id_shelflife_cust, 
   sup.factor_period_cust, 
   sup.dur_shelflife_store,   
   sup.period_id_shelflife_store,   
   sup.factor_period_store,   
   sup.dur_shelflife_wh,   
   sup.period_id_shelflife_wh,   
   sup.factor_period_wh 
    FROM p_lew_core_ac.v_wawi_itm_sup_wh_data_1 AS sup  
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh 
   ON wh.client_id = sup.client_id  
   AND wh.loc_sid_wh = sup.wh_loc_sid  
   AND wh.dwh_actual_fg = 1   
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end 
   AND sup.delete_fg <> 2  
;
