CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_stc_store_item_fv AS
SELECT SSIF.client_id,
 SSIF.dat_dayend,
 SSIF.st_loc_sid AS store_id,
 SSIF.item_sid AS item_id,
 SSIF.dat_formdate,
 SSIF.qty_stc_fv,
  SSIF.price_retail / CRY.rate_currency_exchange AS price_retail,
  SSIF.price_retail_net / CRY.rate_currency_exchange AS price_retail_net,
 CRY.currency_iso_cd -- ,cry.rate_currency_exchange

FROM ldl_p_lew_core_ac.v_wawi_stc_store_item_fv AS SSIF
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON SSIF.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;