CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_warehouse_order_area_hist (client_id, loc_sid_wh, order_area_sid,
wh_order_area_name, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 loc_sid_wh,
 order_area_sid,
 wh_order_area_name,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_warehouse_order_area_hist;