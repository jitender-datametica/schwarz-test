CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_fruits_vegetables_store_info_2 (client_id, loc_sid_store, item_sid,
last_delivery_dt, min_case_size_dec, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid_store,
 item_sid,
 last_delivery_dt,
 min_case_size_dec,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_fruits_vegetables_store_info_2;