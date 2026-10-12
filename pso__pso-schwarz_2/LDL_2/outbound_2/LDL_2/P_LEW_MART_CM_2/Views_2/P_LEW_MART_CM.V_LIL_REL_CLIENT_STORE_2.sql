CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_rel_client_store_2 (client_id, orig_store_nr, move_store_desc) AS SELECT
DISTINCT client_id,
 orig_store_nr,
 move_store_desc
FROM ldl_p_lew_mart_msi_ac.v_org_all_store_merge_2;