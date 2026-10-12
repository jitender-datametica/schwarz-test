CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_store_to_wh_delivery_hist_2 (client_id, loc_sid_store, loc_sid_wh, item_grp_sid
, item_grp_cd, priority, active_from_dt, active_to_dt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid_store,
 loc_sid_wh,
 item_grp_sid,
 item_grp_cd,
 priority,
 active_from_dt,
 active_to_dt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_store_to_wh_delivery_hist_2;