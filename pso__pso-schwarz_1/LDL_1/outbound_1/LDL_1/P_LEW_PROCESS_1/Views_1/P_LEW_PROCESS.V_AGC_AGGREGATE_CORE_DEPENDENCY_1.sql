CREATE OR REPLACE VIEW ldl_p_lew_process.v_agc_aggregate_core_dependency_1 (aggregate_name, core_table_name, last_updated
) AS SELECT aggregate_name,
 core_table_name,
 last_updated
FROM ldl_p_lew_process.t_agc_aggregate_core_dependency_1;