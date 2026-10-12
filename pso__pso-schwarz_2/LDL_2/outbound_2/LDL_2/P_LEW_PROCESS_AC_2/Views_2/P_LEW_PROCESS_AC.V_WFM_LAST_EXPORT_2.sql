CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wfm_last_export_2 (process_name, process_specification, export_specification
, last_export_tmsp, last_export_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_process.v_wfm_last_export_2;