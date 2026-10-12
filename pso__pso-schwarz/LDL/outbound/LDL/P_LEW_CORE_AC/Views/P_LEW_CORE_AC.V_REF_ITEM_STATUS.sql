CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_item_status (client_id, item_status_id, item_status_descr, hq_level_fg,
wh_level_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_status_id,
 item_status_descr,
 hq_level_fg,
 wh_level_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_item_status;