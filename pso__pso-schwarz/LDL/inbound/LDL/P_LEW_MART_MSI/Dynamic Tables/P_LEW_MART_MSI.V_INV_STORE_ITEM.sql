
CREATE OR REPLACE DYNAMIC TABLES P_LEW_MART_MSI.V_INV_STORE_ITEM 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9098 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Inventur   
   #DescEnd#   
   */ 
   
   SELECT   
   sto.client_id
   ,sto.st_loc_sid AS store_id  
   ,sto.item_sid AS item_id  
   ,sto.dat_dayend   
   ,sto.inv_id
   ,wh.src_wh_id AS wh_id  
   ,sto.vat_id
   ,sto.order_area_cd   
   ,sto.pos_nr
   ,sto.weight_fg
   ,sto.qty_case_inv 
   ,sto.qty_piece_inv   
   ,sto.qty_case_inv_new   
   ,sto.qty_piece_inv_new 
   ,sto.pricegroup_wh   
   ,sto.pricegroup_store   
   ,sto.price_retail_inv        / rate_currency_exchange AS price_retail_inv  
   ,sto.price_retail_net_inv    / rate_currency_exchange AS price_retail_net_inv 
   ,sto.price_retail_inv_wh     / rate_currency_exchange AS price_retail_inv_wh 
   ,sto.price_retail_net_inv_wh / rate_currency_exchange AS price_retail_net_inv_wh 
   ,sto.comment_inv
   ,sto.status_inv   
   ,sto.case_size_dec  
   ,cry.currency_iso_cd  
   -- ,cry.rate_currency_exchange   
   
   FROM  
   p_lew_core_ac.v_wawi_inv_store_item AS sto   
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh 
   ON wh.client_id = sto.client_id  
   AND wh.loc_sid_wh =  sto.wh_loc_sid 
    AND wh.dwh_actual_fg = 1  
   INNER JOIN p_lew_core_ac.v_wawi_inv_store AS h  
   ON sto.client_id   = h.client_id 
   AND sto.st_loc_sid    =  h.st_loc_sid  
   AND sto.wh_loc_sid       =  h.wh_loc_sid  
   AND sto.inv_id     = h.inv_id 
   AND sto.dat_dayend = h.dat_dayend   
   AND h.inv_fg   = 71  
   AND h.status_inv_sic = 64  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON    STO.client_id = cry.client_id 
   AND   CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end  
;
