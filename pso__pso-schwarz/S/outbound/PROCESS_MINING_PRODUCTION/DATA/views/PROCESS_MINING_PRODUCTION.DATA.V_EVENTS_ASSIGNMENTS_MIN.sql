CREATE OR REPLACE VIEW process_mining_production_data.v_events_assignments_min (u_task_number, u_order, u_assigned_at,
u_final_assignment, u_assignment_group_name, last_assignment_flag, u_assignment_revoked_at) AS SELECT TICKETS.number AS
 u_task_number,
 t_u_assignment_group_history.u_order,
 t_u_assignment_group_history.u_assigned_at,
 t_u_assignment_group_history.u_final_assignment,
 t_sys_user_group.name AS u_assignment_group_name,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY t_u_assignment_group_history.u_task ORDER BY t_u_assignment_group_history.u_order
       IS NULL DESC, t_u_assignment_group_history.u_order DESC)) = 1
  THEN '1'
  ELSE '0'
  END AS last_assignment_flag,
 COALESCE(cast(CASE
   WHEN CAST(CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY t_u_assignment_group_history.u_task ORDER BY t_u_assignment_group_history.u_order IS NULL DESC, t_u_assignment_group_history.u_order DESC)) = 1
      THEN '1'
      ELSE '0'
      END AS FLOAT64) = 1
   THEN TICKETS.z_solved_at
   ELSE t_u_assignment_group_history.u_assignment_revoked_at
   END as timestamp), DATETIME_ADD(DATE_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL 8 HOUR)) AS u_assignment_revoked_at
FROM process_mining_production_etl.t_u_assignment_group_history
 LEFT JOIN process_mining_production_etl.t_sys_user_group ON t_u_assignment_group_history.u_assignment_group =
  t_sys_user_group.sys_id
 INNER JOIN process_mining_production_data.v_tickets_min_last2years AS TICKETS ON t_u_assignment_group_history.u_task =
  TICKETS.sys_id
WHERE t_u_assignment_group_history.u_sys_class_name IN ('incident', 'u_request', 'problem')
 AND t_u_assignment_group_history.u_order <> 0
QUALIFY (CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY t_u_assignment_group_history.u_task ORDER BY t_u_assignment_group_history.u_order
           IS NULL DESC, t_u_assignment_group_history.u_order DESC)) = 1
      THEN '1'
      ELSE '0'
      END <> '1' OR NOT IF(TICKETS.z_solved_at IS NULL, FALSE, TICKETS.z_solved_at <= t_u_assignment_group_history.sys_updated_on
      )) AND (CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY t_u_assignment_group_history.u_task ORDER BY t_u_assignment_group_history.u_order
           IS NULL DESC, t_u_assignment_group_history.u_order DESC)) = 1
      THEN '1'
      ELSE '0'
      END <> '0' OR NOT t_u_assignment_group_history.u_final_assignment);