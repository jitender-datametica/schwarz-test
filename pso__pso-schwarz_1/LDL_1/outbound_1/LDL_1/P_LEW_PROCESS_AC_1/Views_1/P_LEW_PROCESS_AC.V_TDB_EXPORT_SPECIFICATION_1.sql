CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_tdb_export_specification_1 (client_id, country_lidl_cd, export_cluster_id,
active_from_dt, active_to_dt, dwh_created, dwh_updated) AS SELECT client_id,
 country_lidl_cd,
 export_cluster_id,
 active_from_dt,
 active_to_dt,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_tdb_export_specification_1;