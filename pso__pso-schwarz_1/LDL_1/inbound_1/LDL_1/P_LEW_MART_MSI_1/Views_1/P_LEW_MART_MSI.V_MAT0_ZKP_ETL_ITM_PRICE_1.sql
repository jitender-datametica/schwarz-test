CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_ITM_PRICE_1 as
   SELECT	
      client_id,	
   item_sid AS item_id,	
   pricegroup_id,	
   dat_valid_from,	
   dat_valid_until,	
   vat_id,	
   tare_cd,	
   price_retail,	
   price_retail_net,	
   val_refund,	
   val_net_refund,	
   val_beverage_tax,	
   load_id	
   FROM p_lew_core_ac.v_wawi_itm_price_1	
;