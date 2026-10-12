CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_LC_PRTCL_NEW_CONTEXTS_AS_FOUND_2
AS
   SELECT context_area_type,
   context_area,
   context_load_id,
   fllwng_context_load_id
FROM p_lew_process.v_lc_prtcl_new_contexts_as_found_2
;