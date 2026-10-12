CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wfm_export_delta (core_table_name, process_name, process_specification,
export_specification, last_export_tmsp, last_export_load_id, client_id, dwh_cal_dt, create_timestamp) AS SELECT *
FROM ldl_p_lew_process.v_wfm_export_delta;