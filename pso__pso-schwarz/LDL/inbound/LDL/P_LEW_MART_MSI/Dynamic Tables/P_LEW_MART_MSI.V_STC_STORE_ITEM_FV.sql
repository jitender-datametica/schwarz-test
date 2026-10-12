
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STC_STORE_ITEM_FV 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*    
   #DescStart#    
   #$Revision: 6244 $, $LastChangedBy: hwieber $   
   #SubjectAreas#: Bestand    
   #DescEnd#   
   */ 
   SELECT   
   ssif.client_id,   
   ssif.dat_dayend,  
   ssif.st_loc_sid AS store_id,  
   ssif.item_sid AS item_id,  
   ssif.dat_formdate,   
   ssif.qty_stc_fv,  
   ssif.price_retail / rate_currency_exchange AS price_retail, 
   ssif.price_retail_net / rate_currency_exchange AS price_retail_net,  
   cry.currency_iso_cd  
   -- ,cry.rate_currency_exchange   
   FROM  
   p_lew_core_ac.v_wawi_stc_store_item_fv AS ssif  
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry   
   ON ssif.client_id = cry.client_id   
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
;
