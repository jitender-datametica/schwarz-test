CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_stc_store_item (client_id, store_id, wh_id, item_id, dat_formdate,
qty_stc_calc, qty_stc_inv, qty_stc_real, diff_stc_inv_calc, store_storage_qty, price_retail, price_retail_net,
currency_iso_cd, loc_sid_wh) AS SELECT *
FROM ldl_p_lew_mart_msi.v_stc_store_item;