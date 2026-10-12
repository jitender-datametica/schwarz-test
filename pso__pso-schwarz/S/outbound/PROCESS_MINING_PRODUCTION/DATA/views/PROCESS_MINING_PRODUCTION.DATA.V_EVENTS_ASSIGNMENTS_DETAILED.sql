CREATE OR REPLACE VIEW process_mining_production_data.v_events_assignments_detailed (u_task_number, u_order,
u_assigned_at, u_final_assignment, u_assignment_group_name, last_assignment_flag, u_assignment_revoked_at, time_open,
time_work_in_progress, time_waiting, time_waiting_for_enduser) AS SELECT ASSIGNMENTS.u_task_number,
 ASSIGNMENTS.u_order,
 ASSIGNMENTS.u_assigned_at,
 ASSIGNMENTS.u_final_assignment,
 ASSIGNMENTS.u_assignment_group_name,
 ASSIGNMENTS.last_assignment_flag,
 ASSIGNMENTS.u_assignment_revoked_at,
 STATE_TIMES.time_open,
 STATE_TIMES.time_work_in_progress,
 STATE_TIMES.time_waiting,
 STATE_TIMES.time_waiting_for_enduser
FROM process_mining_production_data.v_events_assignments_min AS ASSIGNMENTS
 LEFT JOIN process_mining_production_data.v_events_states_times_aggregated AS STATE_TIMES ON ASSIGNMENTS.u_task_number =
    STATE_TIMES.u_task_number AND ASSIGNMENTS.u_assignment_group_name = STATE_TIMES.u_assignment_group_name AND
   ASSIGNMENTS.u_order = STATE_TIMES.u_order;
