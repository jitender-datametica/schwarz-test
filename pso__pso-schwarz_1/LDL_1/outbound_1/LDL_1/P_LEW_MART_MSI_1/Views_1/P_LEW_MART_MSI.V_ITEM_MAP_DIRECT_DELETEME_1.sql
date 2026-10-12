CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_item_map_direct_deleteme_1 (client_id, item_sid, item_id, parent_item_sid) AS
SELECT client_id,
 item_sid,
 COALESCE(wawi_dwh_item_id, elwis_dwh_itm_sid, item_sid) AS item_id,
 COALESCE(item_sid_map, item_sid) AS parent_item_sid
FROM ldl_p_lew_core_ac.v_item_map_key_1;