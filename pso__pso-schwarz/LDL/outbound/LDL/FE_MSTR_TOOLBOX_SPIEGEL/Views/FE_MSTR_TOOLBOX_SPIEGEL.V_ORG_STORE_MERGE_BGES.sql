CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_bges (client_id, store_id, store_desc,
orig_store_nr, move_to_store_id, move_store_desc, dashboard_relevant_fg) AS SELECT client_id,
 store_id,
 store_desc,
 orig_store_nr,
 move_to_store_id,
 move_store_desc,
 dashboard_relevant_fg
FROM ldl_p_lew_mart_msi_ac.v_org_store_merge AS STORE
WHERE aspect_id = 1;