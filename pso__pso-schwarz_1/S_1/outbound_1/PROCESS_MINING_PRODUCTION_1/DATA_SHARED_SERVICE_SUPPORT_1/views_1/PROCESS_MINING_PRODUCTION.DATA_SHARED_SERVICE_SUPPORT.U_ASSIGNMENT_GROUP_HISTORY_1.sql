CREATE OR REPLACE VIEW process_mining_production_data_shared_service_support.u_assignment_group_history_1 (sys_created_on
, sys_mod_count, u_assigned_at, u_assignment_group, u_assignment_revoked_at, u_final_assignment, u_order,
u_sys_class_name, u_task, sys_id, sys_updated_on) AS SELECT PARSE_TIMESTAMP('%c', FORMAT_TIMESTAMP('%c', TIMESTAMP(sys_created_on
    , 'UTC'), 'Europe/Berlin')) AS sys_created_on,
 sys_mod_count,
 PARSE_TIMESTAMP('%c', FORMAT_TIMESTAMP('%c', TIMESTAMP(u_assigned_at, 'UTC'), 'Europe/Berlin')) AS u_assigned_at,
 u_assignment_group,
 PARSE_TIMESTAMP('%c', FORMAT_TIMESTAMP('%c', TIMESTAMP(u_assignment_revoked_at, 'UTC'), 'Europe/Berlin')) AS
 u_assignment_revoked_at,
 u_final_assignment,
 u_order,
 u_sys_class_name,
 u_task,
 sys_id,
 PARSE_TIMESTAMP('%c', FORMAT_TIMESTAMP('%c', TIMESTAMP(sys_updated_on, 'UTC'), 'Europe/Berlin')) AS sys_updated_on
FROM process_mining_production_etl.t_u_assignment_group_history_1;