CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lc_prtcl_all_contexts (context_area_type, context_area, context_load_id,
processcontainer, success_state, ctx_has_started_fg, updated_ts) AS SELECT *
FROM ldl_p_lew_process.v_lc_prtcl_all_contexts;