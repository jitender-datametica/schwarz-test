CREATE OR REPLACE VIEW process_mining_production_data.v_events_states_times AS WITH T_SYS_AUDIT_STATES AS (SELECT
    TICKETS.number AS u_task_number,
    t_sys_audit.sys_created_on AS event_timestamp,
    t_sys_audit.tablename,
    ROW_NUMBER() OVER (PARTITION BY t_sys_audit.documentkey ORDER BY t_sys_audit.sys_created_on IS NULL, t_sys_audit.sys_created_on
       , t_sys_audit.record_checkpoint IS NULL, t_sys_audit.record_checkpoint) AS state_event_order,
    t_sys_audit.newvalue,
    t_sys_audit.documentkey,
    t_sys_audit.fieldname
   FROM process_mining_production_etl.t_sys_audit
    INNER JOIN process_mining_production_data.v_tickets_min_last2years AS TICKETS ON t_sys_audit.documentkey = TICKETS.sys_id
     
   WHERE t_sys_audit.tablename IN ('incident', 'u_request', 'problem')
    AND t_sys_audit.fieldname = 'state'
   UNION DISTINCT
   SELECT TICKETS.number AS u_task_number,
    TICKETS.sys_created_on AS event_timestamp,
    t_sys_audit0.tablename,
      (ROW_NUMBER() OVER (PARTITION BY t_sys_audit0.documentkey ORDER BY t_sys_audit0.sys_created_on IS NULL,
         t_sys_audit0.sys_created_on, t_sys_audit0.record_checkpoint IS NULL, t_sys_audit0.record_checkpoint)) - 1 AS
    state_event_order,
    t_sys_audit0.oldvalue AS newvalue,
    t_sys_audit0.documentkey,
    t_sys_audit0.fieldname
   FROM process_mining_production_etl.t_sys_audit AS t_sys_audit0
    INNER JOIN process_mining_production_data.v_tickets_min_last2years AS TICKETS ON t_sys_audit0.documentkey = TICKETS
     .sys_id
   WHERE t_sys_audit0.tablename IN ('incident', 'u_request', 'problem')
    AND t_sys_audit0.fieldname = 'state'
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY t_sys_audit0.documentkey ORDER BY t_sys_audit0.sys_created_on IS NULL,
         t_sys_audit0.sys_created_on, t_sys_audit0.record_checkpoint IS NULL, t_sys_audit0.record_checkpoint)) = 1),
 EVENTS_ASSIGNMENTS AS (SELECT u_task_number,
   u_assigned_at,
   COALESCE(u_assignment_revoked_at, CAST('9999-12-31 23:59:59' AS DATETIME)) AS u_assignment_revoked_at,
   u_assignment_group_name,
   u_order
  FROM process_mining_production_data.v_events_assignments) (SELECT T_SYS_AUDIT_STATES_CURRENT.u_task_number,
   t14.u_order,
    (SELECT MAX(t)
    FROM UNNEST(ARRAY[T_SYS_AUDIT_STATES_CURRENT.EVENT_TIMESTAMP, t14.U_ASSIGNED_AT]) AS t) AS start_timestamp,
   CONCAT('State - ', ticket_mapping_state.matching) AS event,
   'state_change' AS event_level,
    (SELECT MIN(t)
    FROM UNNEST(ARRAY[T_SYS_AUDIT_STATES_NEXT_ROW.EVENT_TIMESTAMP, t14.U_ASSIGNMENT_REVOKED_AT]) AS t) AS end_timestamp
   ,
    DATETIME_DIFF((SELECT MIN(t)
      FROM UNNEST(ARRAY[T_SYS_AUDIT_STATES_NEXT_ROW.EVENT_TIMESTAMP, t14.U_ASSIGNMENT_REVOKED_AT]) AS t), (SELECT MAX(t
        )
      FROM UNNEST(ARRAY[T_SYS_AUDIT_STATES_CURRENT.EVENT_TIMESTAMP, t14.U_ASSIGNED_AT]) AS t), SECOND) / 3600 AS
   duration,
   t14.u_assignment_group_name,
   T_SYS_AUDIT_STATES_CURRENT.event_timestamp AS state_start,
   T_SYS_AUDIT_STATES_NEXT_ROW.event_timestamp AS state_end,
   t14.u_assigned_at,
   t14.u_assignment_revoked_at
  FROM T_SYS_AUDIT_STATES AS T_SYS_AUDIT_STATES_CURRENT
   INNER JOIN process_mining_production_etl.ticket_mapping_state ON T_SYS_AUDIT_STATES_CURRENT.newvalue =
     ticket_mapping_state.raw_data_state AND T_SYS_AUDIT_STATES_CURRENT.tablename = ticket_mapping_state.sys_class_name
   LEFT JOIN T_SYS_AUDIT_STATES AS T_SYS_AUDIT_STATES_NEXT_ROW ON T_SYS_AUDIT_STATES_CURRENT.documentkey =
     T_SYS_AUDIT_STATES_NEXT_ROW.documentkey AND T_SYS_AUDIT_STATES_NEXT_ROW.state_event_order =
      T_SYS_AUDIT_STATES_CURRENT.state_event_order + 1
   LEFT JOIN EVENTS_ASSIGNMENTS AS t14 ON T_SYS_AUDIT_STATES_CURRENT.u_task_number = t14.u_task_number AND
      T_SYS_AUDIT_STATES_NEXT_ROW.event_timestamp > t14.u_assigned_at AND T_SYS_AUDIT_STATES_CURRENT.event_timestamp <
     t14.u_assignment_revoked_at
  ORDER BY start_timestamp NULLS LAST);