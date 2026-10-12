CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lc_prtcl_generic_base_2 (context_area_type, context_area, context_load_id,
processcontainer, success_state, ctx_has_started_fg, updated_ts, tcache_tablename, tcache_database,
tcache_recipient_processname, tcache_processcontainer, active_fg, refreshed_ts, created_ts, ready_ts, delete_ts) AS
SELECT *
FROM ldl_p_lew_process.v_lc_prtcl_generic_base_2;