CREATE OR REPLACE VIEW process_mining_production_eval.t_u_assignment_group_history_dedup_l2_1 (sys_created_on,
sys_mod_count, u_assigned_at, u_assignment_group, u_assignment_revoked_at, u_final_assignment, u_order, u_sys_class_name
, u_task, sys_id, sys_updated_on, seqnum) AS SELECT sys_created_on,
 sys_mod_count,
 u_assigned_at,
 u_assignment_group,
 u_assignment_revoked_at,
 u_final_assignment,
 u_order,
 u_sys_class_name,
 u_task,
 sys_id,
 sys_updated_on,
 ROW_NUMBER() OVER (PARTITION BY sys_id ORDER BY sys_updated_on IS NULL DESC, sys_updated_on DESC) AS seqnum
FROM process_mining_production_etl.t_u_assignment_group_history_l2_1
QUALIFY (ROW_NUMBER() OVER (PARTITION BY sys_id ORDER BY sys_updated_on IS NULL DESC, sys_updated_on DESC)) = 1;