CREATE OR REPLACE VIEW process_mining_production_data.v_events_states_2 AS WITH T_SYS_AUDIT_STATES AS (SELECT TICKETS.number
    AS u_task_number,
   t_sys_audit.sys_created_on AS event_timestamp,
   t_sys_audit.tablename,
   ROW_NUMBER() OVER (PARTITION BY t_sys_audit.documentkey ORDER BY t_sys_audit.sys_created_on IS NULL, t_sys_audit.sys_created_on
      , t_sys_audit.record_checkpoint IS NULL, t_sys_audit.record_checkpoint) AS state_event_order,
   t_sys_audit.newvalue,
   t_sys_audit.documentkey,
   t_sys_audit.fieldname
  FROM process_mining_production_etl.t_sys_audit_2
   INNER JOIN process_mining_production_data.v_tickets_min_last2years_2 AS TICKETS ON t_sys_audit.documentkey = TICKETS.sys_id
    
  WHERE t_sys_audit.tablename IN ('incident', 'u_request', 'problem')
   AND t_sys_audit.fieldname = 'state'), EVENTS_ASSIGNMENTS AS (SELECT u_task_number,
   u_assigned_at,
   COALESCE(u_assignment_revoked_at, CAST('9999-12-31 23:59:59' AS DATETIME)) AS u_assignment_revoked_at,
   u_assignment_group_name
  FROM process_mining_production_data.v_events_assignments_2) (SELECT *
  FROM (SELECT T_SYS_AUDIT_STATES_CURRENT.u_task_number,
      T_SYS_AUDIT_STATES_CURRENT.event_timestamp AS start_timestamp,
      CONCAT('State - ', ticket_mapping_state.matching) AS event,
      'state_change' AS event_level,
      T_SYS_AUDIT_STATES_NEXT_ROW.event_timestamp AS end_timestamp,
      t4.u_assignment_group_name
     FROM T_SYS_AUDIT_STATES AS T_SYS_AUDIT_STATES_CURRENT
      INNER JOIN process_mining_production_etl.ticket_mapping_state_2 ON T_SYS_AUDIT_STATES_CURRENT.newvalue =
        ticket_mapping_state.raw_data_state AND T_SYS_AUDIT_STATES_CURRENT.tablename = ticket_mapping_state.sys_class_name
        
      LEFT JOIN T_SYS_AUDIT_STATES AS T_SYS_AUDIT_STATES_NEXT_ROW ON T_SYS_AUDIT_STATES_CURRENT.documentkey =
        T_SYS_AUDIT_STATES_NEXT_ROW.documentkey AND T_SYS_AUDIT_STATES_NEXT_ROW.state_event_order =
         T_SYS_AUDIT_STATES_CURRENT.state_event_order + 1
      LEFT JOIN EVENTS_ASSIGNMENTS AS t4 ON T_SYS_AUDIT_STATES_CURRENT.u_task_number = t4.u_task_number AND
         T_SYS_AUDIT_STATES_CURRENT.event_timestamp >= t4.u_assigned_at AND T_SYS_AUDIT_STATES_CURRENT.event_timestamp <
        t4.u_assignment_revoked_at
     UNION DISTINCT
     SELECT TICKETS.u_task_number,
      TICKETS.sys_created_on AS start_timestamp,
      CONCAT('State - ', STATE_NAME.matching) AS event,
      'state_change' AS event_level,
      t_sys_audit1.sys_created_on AS end_timestamp,
      TICKETS.u_task_u_first_assignment_group_name AS u_assignment_group_name
     FROM process_mining_production_etl.t_sys_audit_2 AS t_sys_audit1
      INNER JOIN process_mining_production_data.v_tickets_last2years_2 AS TICKETS ON t_sys_audit1.documentkey = TICKETS.u_task_sys_id
       
      LEFT JOIN process_mining_production_etl.ticket_mapping_state_2 AS STATE_NAME ON t_sys_audit1.oldvalue = STATE_NAME.raw_data_state
         AND t_sys_audit1.tablename = STATE_NAME.sys_class_name
     WHERE t_sys_audit1.tablename IN ('incident', 'u_request', 'problem')
      AND t_sys_audit1.fieldname = 'state'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY t_sys_audit1.documentkey ORDER BY t_sys_audit1.sys_created_on IS NULL,
           t_sys_audit1.sys_created_on, t_sys_audit1.record_checkpoint IS NULL, t_sys_audit1.record_checkpoint)) = 1));