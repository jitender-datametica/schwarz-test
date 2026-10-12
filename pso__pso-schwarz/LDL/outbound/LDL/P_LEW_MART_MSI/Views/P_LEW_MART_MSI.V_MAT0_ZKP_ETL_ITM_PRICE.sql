CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_zkp_etl_itm_price AS SELECT client_id,
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
FROM ldl_p_lew_core_ac.v_wawi_itm_price;