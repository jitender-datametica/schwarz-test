
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_STORE_ITEM_CORR_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart# 
   #$Revision: 9099 $, $LastChangedBy: aarnold $   
   #SubjectAreas#: Inventur_1   
   #DescEnd#   
   */ 
   SELECT   
   sic.client_id, 
   sic.inv_id, 
   sic.item_sid AS item_id,   
   sic.st_loc_sid AS store_id,   
   wh.src_wh_id AS wh_id,  
   sic.order_area_cd,   
   sic.dat_dayend,   
   sic.pos_nr, 
   sic.weight_fg, 
   sic.price_retail_inv_item_corr     / rate_currency_exchange AS price_retail_inv_item_corr,   
   sic.price_retail_new_inv_item_corr / rate_currency_exchange AS price_retail_new_inv_item_corr,  
   sic.price_rtl_net_inv_item_corr / rate_currency_exchange    AS price_retail_net_inv_item_corr,  
   sic.prc_rtl_new_net_inv_item_corr  / rate_currency_exchange AS prc_rtl_new_net_inv_item_corr,   
   sic.qty_case_inv_item_corr,   
   sic.qty_case_new_inv_item_corr,  
   sic.qty_piece_inv_item_corr,  
   sic.qty_piece_new_inv_item_corr, 
   sic.case_size_dec,   
   cry.currency_iso_cd  
   -- ,cry.rate_currency_exchange   
   FROM  
   p_lew_core_ac.v_wawi_inv_store_item_corr_1 AS sic 
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh 
   ON wh.client_id = sic.client_id  
   AND wh.loc_sid_wh =  sic.wh_loc_sid 
    AND wh.dwh_actual_fg = 1  
   INNER JOIN p_lew_core_ac.v_wawi_inv_store_1 AS h  
   ON  sic.client_id  = h.client_id 
   AND sic.st_loc_sid    =  h.st_loc_sid  
   AND sic.wh_loc_sid       =  h.wh_loc_sid  
   AND sic.inv_id     = h.inv_id 
   AND sic.dat_dayend = h.dat_dayend   
   AND h.inv_fg   = 71  
   AND h.status_inv_sic = 64  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry   
   ON    sic.client_id = cry.client_id 
   AND   CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end  
;
