CREATE OR REPLACE VIEW process_mining_production_data.v_events_states_times_aggregated_per_ticket_helper (u_task_number
, u_assignment_group_name, time_new, time_open, time_work_in_progress, time_waiting_for_enduser,
time_waiting_for_external, time_waiting_for_problem, time_total) AS SELECT u_task_number,
 u_assignment_group_name,
 SUM(CASE
   WHEN event = 'State - New'
   THEN duration
   ELSE 0
   END) AS time_new,
 SUM(CASE
   WHEN event = 'State - Open'
   THEN duration
   ELSE 0
   END) AS time_open,
 SUM(CASE
   WHEN event = 'State - Work in progress'
   THEN duration
   ELSE 0
   END) AS time_work_in_progress,
 SUM(CASE
   WHEN event LIKE 'State - Wait for enduser%'
   THEN duration
   ELSE 0
   END) AS time_waiting_for_enduser,
 SUM(CASE
   WHEN event LIKE 'State - Wait for external%'
   THEN duration
   ELSE 0
   END) AS time_waiting_for_external,
 SUM(CASE
   WHEN event LIKE 'State - Wait for problem%'
   THEN duration
   ELSE 0
   END) AS time_waiting_for_problem,
 SUM(duration) AS time_total
FROM process_mining_production_data.v_events_states_times
GROUP BY u_task_number,
 u_assignment_group_name;