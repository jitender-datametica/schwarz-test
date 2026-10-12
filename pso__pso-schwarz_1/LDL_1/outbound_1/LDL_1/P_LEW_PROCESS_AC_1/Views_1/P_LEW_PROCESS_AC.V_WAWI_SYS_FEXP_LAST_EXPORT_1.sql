CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_fexp_last_export_1 (jobname, instance_id, ab_run_id, load_id,
max_load_id, table_name, export_name) AS SELECT jobname,
 instance_id,
 ab_run_id,
 load_id,
 max_load_id,
 table_name,
 export_name
FROM ldl_p_lew_process.t_wawi_sys_fexp_last_export_1;