
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_PRICE 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)   
   #DescEnd#   
   */ 
   SELECT   
   ip.client_id,  
   ip.item_sid AS item_id, 
   ip.dat_valid_from AS dat_rec_start, 
   ip.dat_valid_until AS dat_rec_end,  
   ip.pricegroup_id, 
   ip.vat_id,  
   ip.tare_cd, 
   ip.price_retail / rate_currency_exchange AS price_retail,   
   ip.price_retail_net / rate_currency_exchange AS price_retail_net, 
   ip.val_refund / rate_currency_exchange AS val_refund, 
   ip.val_beverage_tax / rate_currency_exchange AS val_beverage_tax, 
   cry.currency_iso_cd  
   -- ,cry.rate_currency_exchange   
   FROM  
   p_lew_core_ac.v_wawi_itm_price AS ip   
   
   JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON ip.client_id = cry.client_id  
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
;
