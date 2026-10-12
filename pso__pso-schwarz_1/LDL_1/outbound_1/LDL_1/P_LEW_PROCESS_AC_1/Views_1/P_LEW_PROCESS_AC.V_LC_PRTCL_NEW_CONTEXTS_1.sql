CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lc_prtcl_new_contexts_1 (context_area_type, context_area, context_load_id,
processcontainer, success_state, fllwngctx_lid, fllwing_ctx_has_started) AS SELECT *
FROM ldl_p_lew_process.v_lc_prtcl_new_contexts_1;