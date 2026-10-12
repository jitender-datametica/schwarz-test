CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_store_day_item_ejr_asis_2 (client_id, currency_iso_cd, store_id,
item_id, dat_formdate, qty_ejr_asis, val_net_ejr_asis, move_to_store_id) AS SELECT client_id,
 currency_iso_cd,
 store_id,
 item_id,
 dat_formdate,
 qty_ejr_asis,
 val_net_ejr_asis,
 move_to_store_id
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_store_day_item_ejr_asis_2;