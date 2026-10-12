CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_meta_registry_files_1 (file_id, file_name, interface_name, data_provider
, delivery_cd, processing_ts, command, note, status_1, dwh_created, dwh_updated) AS SELECT file_id,
 file_name,
 interface_name,
 data_provider,
 delivery_cd,
 processing_ts,
 command,
 note,
 status_1,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_cm.v_lil_meta_registry_files_1;