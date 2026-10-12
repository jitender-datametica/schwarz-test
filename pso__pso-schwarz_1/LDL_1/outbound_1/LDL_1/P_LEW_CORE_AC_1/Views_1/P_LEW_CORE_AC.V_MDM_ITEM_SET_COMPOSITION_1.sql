CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_set_composition_1 (client_id, mdm_item_set_sid, mdm_item_style_sid,
style_qty, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_set_sid,
 mdm_item_style_sid,
 style_qty,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_set_composition_1;