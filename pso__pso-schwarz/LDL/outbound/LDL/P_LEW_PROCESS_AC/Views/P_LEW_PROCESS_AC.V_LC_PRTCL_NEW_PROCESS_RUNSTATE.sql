CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lc_prtcl_new_process_runstate (tcache_database, tcache_tablename,
tcache_recipient_processname, tcache_processcontainer, context_area_type, context_area, context_load_id, ready_ts,
updated_ts, last_touched_ts, cnt_wait4total, cnt_ready, cnt_wait4pending, ctx_open_fg, ctx_started_fg,
before_success_state, ctx_state_new, tcache_deleted_since, is_before_state_protected, ctx_state) AS SELECT *
FROM ldl_p_lew_process.v_lc_prtcl_new_process_runstate;