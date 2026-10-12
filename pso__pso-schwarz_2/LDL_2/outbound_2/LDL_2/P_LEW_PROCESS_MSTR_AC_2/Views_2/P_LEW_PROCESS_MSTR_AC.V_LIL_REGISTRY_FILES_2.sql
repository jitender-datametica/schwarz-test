CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_registry_files_2 (file_id, file_name, interface_name, data_provider
, delivery_cd, checksum, processing_ts, command, note, status_2, dwh_load_id, dwh_created, dwh_updated) AS SELECT file_id
 ,
 file_name,
 interface_name,
 data_provider,
 delivery_cd,
 checksum,
 processing_ts,
 command,
 note,
 status_2,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_registry_files_2;