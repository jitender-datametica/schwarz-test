CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_variant_client_hist (client_id, mdm_item_variant_sid,
client_id_recipient, int_org_sid, client_block_id, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 mdm_item_variant_sid,
 client_id_recipient,
 int_org_sid,
 client_block_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_variant_client_hist;