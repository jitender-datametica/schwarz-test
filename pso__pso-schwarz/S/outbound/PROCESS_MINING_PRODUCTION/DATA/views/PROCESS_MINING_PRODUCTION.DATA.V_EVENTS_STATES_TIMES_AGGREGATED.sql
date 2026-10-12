CREATE OR REPLACE VIEW process_mining_production_data.v_events_states_times_aggregated (u_task_number,
u_assignment_group_name, u_order, time_open, time_work_in_progress, time_waiting, time_waiting_for_enduser) AS SELECT
 u_task_number,
 u_assignment_group_name,
 u_order,
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
   WHEN event LIKE 'State - Wait%'
   THEN duration
   ELSE 0
   END) AS time_waiting,
 SUM(CASE
   WHEN event LIKE 'State - Wait for enduser%'
   THEN duration
   ELSE 0
   END) AS time_waiting_for_enduser
FROM process_mining_production_data.v_events_states_times
GROUP BY u_task_number,
 u_assignment_group_name,
 u_order;