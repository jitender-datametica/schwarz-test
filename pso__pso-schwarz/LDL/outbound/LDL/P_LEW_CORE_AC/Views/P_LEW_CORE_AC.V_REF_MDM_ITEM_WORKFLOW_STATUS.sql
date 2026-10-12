CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_workflow_status (client_id, workflow_status_id, workflow_status
, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 workflow_status_id,
 workflow_status,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_workflow_status;