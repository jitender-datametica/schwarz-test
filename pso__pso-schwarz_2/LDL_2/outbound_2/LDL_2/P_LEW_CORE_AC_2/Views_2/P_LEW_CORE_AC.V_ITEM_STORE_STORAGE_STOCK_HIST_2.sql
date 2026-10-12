CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_store_storage_stock_hist_2 (client_id, item_sid, loc_sid,
store_storage_qty, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 item_sid,
 loc_sid,
 store_storage_qty,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_store_storage_stock_hist_2;