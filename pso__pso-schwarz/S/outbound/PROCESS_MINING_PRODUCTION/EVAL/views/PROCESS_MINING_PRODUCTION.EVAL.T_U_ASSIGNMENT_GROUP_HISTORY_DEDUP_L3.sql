CREATE OR REPLACE VIEW process_mining_production_eval.t_u_assignment_group_history_dedup_l3 (u_assigned_by,
u_assignment_revoked_by, sys_id, sys_updated_on, seqnum) AS SELECT u_assigned_by,
 u_assignment_revoked_by,
 sys_id,
 sys_updated_on,
 ROW_NUMBER() OVER (PARTITION BY sys_id ORDER BY sys_updated_on IS NULL DESC, sys_updated_on DESC) AS seqnum
FROM process_mining_production_etl.t_u_assignment_group_history_l3
QUALIFY (ROW_NUMBER() OVER (PARTITION BY sys_id ORDER BY sys_updated_on IS NULL DESC, sys_updated_on DESC)) = 1;