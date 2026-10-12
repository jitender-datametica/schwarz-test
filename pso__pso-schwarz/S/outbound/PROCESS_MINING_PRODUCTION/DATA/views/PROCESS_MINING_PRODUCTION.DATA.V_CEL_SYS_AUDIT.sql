CREATE OR REPLACE VIEW process_mining_production_data.v_cel_sys_audit (sys_id, documentkey, sys_created_on, fieldname,
oldvalue, newvalue, user) AS SELECT t_sys_audit.sys_id,
 t_sys_audit.documentkey,
 t_sys_audit.sys_created_on,
 t_sys_audit.fieldname,
 t_sys_audit.oldvalue,
 t_sys_audit.newvalue,
 NULL AS user
FROM process_mining_production_etl.t_sys_audit
 INNER JOIN process_mining_production_data.v_cel_incident ON t_sys_audit.documentkey = v_cel_incident.sys_id
WHERE t_sys_audit.tablename = 'incident'
 AND t_sys_audit.sys_created_on > CAST('2024-03-01 00:00:00' AS DATETIME)
 AND t_sys_audit.fieldname IN ('assignment_group', 'category', 'cmdb_ci', 'description', 'short_description',
   'work_notes', 'priority', 'escalation', 'state', 'major_incident_state', 'comments', 'u_end_user_escalation',
   'u_escalation_date', 'u_escalation_comment');