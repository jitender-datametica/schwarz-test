CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_bom_hist (client_id, item_bom_sid, bom_alternative_cd, version_counter,
active_from_dt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_bom_sid,
 bom_alternative_cd,
 version_counter,
 active_from_dt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_bom_hist;