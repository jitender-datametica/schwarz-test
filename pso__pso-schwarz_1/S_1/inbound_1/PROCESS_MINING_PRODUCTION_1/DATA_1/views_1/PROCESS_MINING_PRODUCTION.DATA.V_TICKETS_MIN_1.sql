create or replace view PROCESS_MINING_PRODUCTION.DATA.V_TICKETS_MIN_1(
	SYS_ID,
	NUMBER,
	SYS_CLASS_NAME,
	U_CALLER,
	LOCATION_1,
	U_REGION,
	U_DIVISION,
	U_RESOLVED_BY_GROUP,
	CMDB_CI,
	U_FIRST_ASSIGNMENT_GROUP,
	U_CLOSE_CODE,
	BUSINESS_SERVICE,
	U_CAUSATIVE_CI,
	STATE,
	U_DIVISION_BUSINESS_REGION,
	U_END_USER_ESCALATION,
	Z_REOPEN_COUNT,
	U_SOURCE,
	Z_SOLVED_AT,
	Z_PRIORITY,
	U_MASTER_INCIDENT,
	PARENT_INCIDENT,
	Z_IS_MAJOR,
	U_AFFECTED_CIS,
	U_AFFECTED_DIVISIONS,
	SYS_CREATED_ON,
	U_WRONG_TICKET_ASSIGNMENT_COUNT,
	U_TICKET_DESCRIPTION_INCOMPLETE_COUNT,
	U_SYSTEM_OUTAGE,
	U_SYSTEM_OUTAGE_IN_MIN,
	U_COUNT_SHOULD_HAVE_BEEN_SOLVED_BY_EARLIER_SUPPORT_LEVEL,
	U_KNOWLEDGE_IS_MISSING
) as
select sys_id, number, sys_class_name , u_caller, location_1, u_region, u_division, u_resolved_by_group, cmdb_ci, u_first_assignment_group, u_close_code, business_service, u_causative_ci, state, u_division_business_region, u_end_user_escalation, reopen_count as z_reopen_count, u_source, resolved_at as z_solved_at, priority as z_priority, u_master_incident, parent_incident, u_is_major_incident as z_is_major, null as u_affected_cis, null as u_affected_divisions, sys_created_on, u_wrong_ticket_assignment_count, u_ticket_description_incomplete_count, u_system_outage, u_system_outage_in_min, u_count_should_have_been_solved_by_earlier_support_level, u_knowledge_is_missing from etl.t_incident_1
union
select sys_id, number, sys_class_name , u_caller, location_1, u_region, u_division, u_resolved_by_group, cmdb_ci, u_first_assignment_group,  u_close_code, business_service, u_causative_ci, state, u_division_business_region, u_end_user_escalation, u_reopen_count as z_reopen_count , u_source, u_completed_at as z_solved_at, urgency as z_priority, null as u_master_incident, null as parent_incident, null as z_is_major, null as u_affected_cis, null as u_affected_divisions, sys_created_on, u_wrong_ticket_assignment_count, u_ticket_description_incomplete_count, null as u_system_outage, null as u_system_outage_in_min, u_count_should_have_been_solved_by_earlier_support_level, u_knowledge_is_missing from etl.t_u_request_1 where sys_class_name ='u_request'
union
select sys_id, number, sys_class_name , u_caller, location_1, u_region, u_division, u_resolved_by_group, cmdb_ci, u_first_assignment_group, u_close_code, business_service, u_causative_ci, state, u_division_business_region, u_end_user_escalation, null as z_reopen_count, null as u_source, u_resolved_at as z_solved_at, priority as z_priority, null as u_master_incident, null as parent_incident, u_is_major_problem as z_is_major, u_affected_cis, u_affected_divisions, sys_created_on, null as u_wrong_ticket_assignment_count, null as u_ticket_description_incomplete_count, null as u_system_outage,  null as u_system_outage_in_min, null as u_count_should_have_been_solved_by_earlier_support_level, null as u_knowledge_is_missing from etl.t_problem_1;