CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_rel_client_store (client_id, orig_store_nr, move_store_desc) AS SELECT
DISTINCT *
FROM ldl_p_lew_mart_cm.v_lil_rel_client_store;