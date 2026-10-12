CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_range_selection_2 (client_id, mdm_range_sel_sid, src_prog_doc_ref,
range_plan_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_mdm_range_selection_2;