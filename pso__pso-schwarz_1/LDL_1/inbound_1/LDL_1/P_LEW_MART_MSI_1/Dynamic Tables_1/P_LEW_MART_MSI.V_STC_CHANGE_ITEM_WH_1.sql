
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STC_CHANGE_ITEM_WH_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9151 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Inventur_1   
   #DescEnd#   
   */ 
   SELECT   
   scih.client_id,   
   wh.src_wh_id AS wh_id,  
   scih.item_sid AS item_id,  
   scih.dat_formdate,   
   scih.inv_id_stc_change, 
   scih.stc_change_type_cd,   
   scih.qty_piece_stc_change, 
   scih.price_retail_stc_change / rate_currency_exchange AS price_retail_stc_change,   
   scih.price_retail_net_stc_change / rate_currency_exchange AS price_retail_net_stc_change, 
   cry.currency_iso_cd  
   --  , cry.rate_currency_exchange 
   
   FROM  
   p_lew_core_ac.v_wawi_stc_change_item_wh_1 AS scih 
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh 
   ON wh.client_id = scih.client_id 
   AND wh.loc_sid_wh =  scih.wh_loc_sid   
   AND wh.dwh_actual_fg = 1   
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry   
   ON scih.client_id = cry.client_id   
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
;
