

CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_cntl_etl_logging_1 AS SELECT run_id_seq,
 run_ts,
 run_day_id,
 run_clustering_desc,
 application_name,
 module_name,
 component_name,
 start_run_ts,
 end_run_ts,
 run_time_min,
 run_time_sec,
 query_tag,
 sf_user,
 sf_warehouse,
 sf_role,
 sf_database,
 sf_schema,
 sf_session,
 sf_client,
 run_ldesc,
 record_processed_nr,
 start_processig_flag,
 end_processig_flag,
 module_level_flag,
 component_level_flag,
 completed_run_flag,
   ((DENSE_RANK() OVER (ORDER BY run_id_seq IS NULL DESC, run_id_seq DESC)) - 1) * - 1 AS moving_run_id_from_current
FROM ldl_p_lew_mart_pit_onprem.t_cntl_etl_logging_1 AS LG
WHERE deleted_fg = 0;


