CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_range_selection (client_id, mdm_range_sel_sid, src_prog_doc_ref,
range_plan_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_range_sel_sid,
 src_prog_doc_ref,
 range_plan_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_range_selection;