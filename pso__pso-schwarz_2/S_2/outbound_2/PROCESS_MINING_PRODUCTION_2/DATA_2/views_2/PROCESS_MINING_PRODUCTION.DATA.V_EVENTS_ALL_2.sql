CREATE OR REPLACE VIEW process_mining_production_data.v_events_all_2 (u_task_number, start_timestamp, event, end_timestamp
, u_order, event_level, u_assignment_group_name) AS SELECT u_task_number,
 start_timestamp,
 event,
 end_timestamp,
 9999 AS u_order,
 event_level,
 u_assignment_group_name
FROM process_mining_production_data.v_events_states_2
UNION DISTINCT
SELECT u_task_number,
 u_assigned_at AS start_timestamp,
 u_assignment_group_name AS event,
 u_assignment_revoked_at AS end_timestamp,
 u_order,
 'assignment' AS event_level,
 u_assignment_group_name
FROM process_mining_production_data.v_events_assignments_2;