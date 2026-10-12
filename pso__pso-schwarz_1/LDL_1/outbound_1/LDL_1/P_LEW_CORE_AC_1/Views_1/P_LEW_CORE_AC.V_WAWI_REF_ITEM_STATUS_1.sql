CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_item_status_1 (client_id, item_status, item_status_desc, language_id,
load_id) AS SELECT client_id,
 item_status,
 item_status_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_item_status_1;