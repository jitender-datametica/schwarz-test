CREATE OR REPLACE VIEW process_mining_production_eval.t_u_request_dedup_l3 (additional_assignee_list, assigned_to,
closed_by, opened_by, u_assigned_to_history, u_caller, u_caller_country, u_completed_by, u_current_obv, u_personal_data
, u_service_manager, u_update_user_history, u_updated_by, work_notes_list, sys_id, sys_updated_on, seqnum) AS SELECT
 additional_assignee_list,
 assigned_to,
 closed_by,
 opened_by,
 u_assigned_to_history,
 u_caller,
 u_caller_country,
 u_completed_by,
 u_current_obv,
 u_personal_data,
 u_service_manager,
 u_update_user_history,
 u_updated_by,
 work_notes_list,
 sys_id,
 sys_updated_on,
 ROW_NUMBER() OVER (PARTITION BY sys_id ORDER BY sys_updated_on IS NULL DESC, sys_updated_on DESC) AS seqnum
FROM process_mining_production_etl.t_u_request_l3
QUALIFY (ROW_NUMBER() OVER (PARTITION BY sys_id ORDER BY sys_updated_on IS NULL DESC, sys_updated_on DESC)) = 1;