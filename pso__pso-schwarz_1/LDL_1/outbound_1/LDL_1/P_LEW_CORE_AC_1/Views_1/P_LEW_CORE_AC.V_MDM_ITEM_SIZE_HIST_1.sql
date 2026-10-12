CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_size_hist_1 (client_id, mdm_item_size_sid, size_name, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_size_sid,
 size_name,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_size_hist_1;