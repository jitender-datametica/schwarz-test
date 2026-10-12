CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_agc_client_cluster_1 AS SELECT client_id,
 sap_cluster_cd,
 pos_cluster_cd,
 last_updated,
 last_load_id
FROM ldl_p_lew_process.t_agc_client_cluster_1;