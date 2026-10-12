CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_agc_aggregate_core_dependency (aggregate_name, core_table_name,
last_updated) AS SELECT *
FROM ldl_p_lew_process.v_agc_aggregate_core_dependency;