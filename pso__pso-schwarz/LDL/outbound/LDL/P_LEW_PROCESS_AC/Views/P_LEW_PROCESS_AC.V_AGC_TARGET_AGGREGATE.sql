CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_agc_target_aggregate (aggregate_name, target_database, source_database,
source_view, delta_mode, last_updated) AS SELECT aggregate_name,
 target_database,
 source_database,
 source_view,
 delta_mode,
 last_updated
FROM ldl_p_lew_process.t_agc_target_aggregate;