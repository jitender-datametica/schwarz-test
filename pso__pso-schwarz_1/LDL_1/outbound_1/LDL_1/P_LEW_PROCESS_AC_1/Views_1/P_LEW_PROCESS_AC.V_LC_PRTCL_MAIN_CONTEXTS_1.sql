CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lc_prtcl_main_contexts_1 (context_load_id, processcontainer, updated_ts,
main_success_state, main_ctx_has_started_fg, fllwing_ctx_lid, fllwing_ctx_has_started) AS SELECT context_load_id,
 processcontainer,
 updated_ts,
 main_success_state,
 main_ctx_has_started_fg,
 fllwing_ctx_lid,
 fllwing_ctx_has_started
FROM ldl_p_lew_process.v_lc_prtcl_main_contexts_1;