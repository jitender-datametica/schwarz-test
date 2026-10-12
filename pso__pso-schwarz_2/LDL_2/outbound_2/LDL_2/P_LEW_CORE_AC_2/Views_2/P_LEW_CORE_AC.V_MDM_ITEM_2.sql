CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_2 (client_id, mdm_item_sid, src_item_doc_ref, mdm_item_name, item_ian
, range_plan_cd, item_selection_nr, step_item_nr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_sid,
 src_item_doc_ref,
 mdm_item_name,
 item_ian,
 range_plan_cd,
 item_selection_nr,
 step_item_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_2;