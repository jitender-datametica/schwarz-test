CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_store_order_area_time_range_hist (client_id, loc_sid_store, order_area_sid,
loc_sid_wh, wh_order_time_range_sid, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 loc_sid_store,
 order_area_sid,
 loc_sid_wh,
 wh_order_time_range_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_store_order_area_time_range_hist;