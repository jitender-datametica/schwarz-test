CREATE OR REPLACE VIEW process_mining_production_data.v_cel_sys_audit_1week_gb_2 (sys_id, documentkey, sys_created_on,
fieldname, oldvalue, newvalue, user) AS SELECT t_sys_audit.sys_id,
 t_sys_audit.documentkey,
 t_sys_audit.sys_created_on,
 t_sys_audit.fieldname,
 t_sys_audit.oldvalue,
 t_sys_audit.newvalue,
 NULL AS user
FROM process_mining_production_etl.t_sys_audit_2
 INNER JOIN process_mining_production_data.v_cel_incident_1week_gb_2 ON t_sys_audit.documentkey = v_cel_incident_1week_gb_2
  .sys_id
WHERE t_sys_audit.tablename = 'incident'
 AND t_sys_audit.sys_created_on > CAST('2024-03-01 00:00:00' AS DATETIME)
 AND t_sys_audit.fieldname IN ('assignment_group', 'category', 'cmdb_ci', 'short_description', 'priority', 'escalation'
   , 'state', 'major_incident_state', 'u_end_user_escalation', 'u_escalation_date');