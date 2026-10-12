CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_load_control_app_act_tms_tmp (load_process_application_id,
load_process_sap_cluster_cd, application_load_start_dt, application_load_start_tms, load_id, dwh_inserted, dwh_updated)
AS SELECT load_process_application_id,
 load_process_sap_cluster_cd,
 application_load_start_dt,
 application_load_start_tms,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_process.t_load_control_app_act_tms_tmp;