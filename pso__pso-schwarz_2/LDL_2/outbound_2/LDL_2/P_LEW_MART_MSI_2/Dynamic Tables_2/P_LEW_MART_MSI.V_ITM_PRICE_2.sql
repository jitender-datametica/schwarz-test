CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_price_2
 AS
SELECT IP.client_id,
 IP.item_sid AS item_id,
 IP.dat_valid_from AS dat_rec_start,
 IP.dat_valid_until AS dat_rec_end,
 IP.pricegroup_id,
 IP.vat_id,
 IP.tare_cd,
  IP.price_retail / CRY.rate_currency_exchange AS price_retail,
  IP.price_retail_net / CRY.rate_currency_exchange AS price_retail_net,
  IP.val_refund / CRY.rate_currency_exchange AS val_refund,
  IP.val_beverage_tax / CRY.rate_currency_exchange AS val_beverage_tax,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_itm_price_2 AS IP
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON IP.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;

