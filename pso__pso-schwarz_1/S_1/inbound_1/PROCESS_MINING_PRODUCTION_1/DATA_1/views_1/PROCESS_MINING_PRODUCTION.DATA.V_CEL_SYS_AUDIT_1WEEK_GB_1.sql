create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_SYS_AUDIT_1WEEK_GB_1(
	SYS_ID,
	DOCUMENTKEY,
	SYS_CREATED_ON,
	FIELDNAME,
	OLDVALUE,
	NEWVALUE,
	USER
) as
select t_sys_audit.sys_id, documentkey, t_sys_audit.sys_created_on, fieldname, oldvalue, newvalue, NULL AS user
from etl.t_sys_audit_1
inner join data.v_cel_incident_1week_gb_1 on v_cel_incident_1week_gb.sys_id = t_sys_audit.documentkey
where tablename = 'incident' and sys_created_on > '2024-03-01' and fieldname IN
('assignment_group', 'category', 'cmdb_ci', 'short_description', 'priority', 'escalation', 'state', 'major_incident_state', 'u_end_user_escalation', 'u_escalation_date');