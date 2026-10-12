CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_stc_store_item_fv_2 (st_loc_sid, client_id, item_sid, dat_formdate,
dat_dayend, qty_stc_fv, price_retail, price_retail_net, val_vat, price_buying, load_id) AS SELECT st_loc_sid,
 client_id,
 item_sid,
 dat_formdate,
 dat_dayend,
 qty_stc_fv,
 price_retail,
 price_retail_net,
 val_vat,
 price_buying,
 load_id
FROM ldl_p_lew_core.t_wawi_stc_store_item_fv_2;