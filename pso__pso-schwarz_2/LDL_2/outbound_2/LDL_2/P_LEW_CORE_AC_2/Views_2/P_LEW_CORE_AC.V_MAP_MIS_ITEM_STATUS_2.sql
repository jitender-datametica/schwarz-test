CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_item_status_2 (client_id, item_status_cd, item_status_descr,
mis_itm_state_id, mis_state_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_status_cd,
 item_status_descr,
 mis_itm_state_id,
 mis_state_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_item_status_2;