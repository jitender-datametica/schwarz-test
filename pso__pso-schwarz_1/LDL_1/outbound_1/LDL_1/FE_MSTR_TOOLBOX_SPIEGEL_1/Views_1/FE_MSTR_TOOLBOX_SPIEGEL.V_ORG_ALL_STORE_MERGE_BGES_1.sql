CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_org_all_store_merge_bges_1 (client_id, move_to_store_id,
move_store_desc, wh_id, orig_store_nr, dashboard_relevant_fg) AS SELECT client_id,
 move_to_store_id,
 move_store_desc,
 wh_id,
 orig_store_nr,
 dashboard_relevant_fg
FROM ldl_p_lew_mart_msi_ac.v_org_all_store_merge_1 AS STORE
WHERE aspect_id = 1;