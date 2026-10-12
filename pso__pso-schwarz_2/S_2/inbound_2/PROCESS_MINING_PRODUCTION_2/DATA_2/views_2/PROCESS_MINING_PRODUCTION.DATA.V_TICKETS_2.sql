create or replace view PROCESS_MINING_PRODUCTION.DATA.V_TICKETS_2(
	U_TASK_NUMBER,
	U_TASK_SYS_CLASS_NAME,
	U_TASK_U_REGION_U_CODE,
	U_TASK_U_DIVISION_U_NAME,
	U_DIVISION_BUSINESS_REGION,
	U_TASK_U_DIVISION_BUSINESS_REGION_U_LABEL,
	U_TASK_U_RESOLVED_BY_GROUP_NAME,
	U_TASK_U_RESOLVED_BY_GROUP_U_DIVISION_U_NAME,
	U_TASK_U_RESOLVED_BY_GROUP_U_REGION_U_CODE,
	U_TASK_U_RESOLVED_BY_GROUP_MANAGER_DEPARTMENT_NAME,
	U_TASK_U_FIRST_ASSIGNMENT_GROUP_NAME,
	U_TASK_U_FIRST_ASSIGNMENT_GROUP_U_DIVISION_U_NAME,
	U_TASK_U_FIRST_ASSIGNMENT_GROUP_U_REGION_U_CODE,
	U_TASK_U_FIRST_ASSIGNMENT_GROUP_MANAGER_DEPARTMENT_NAME,
	U_TASK_CMDB_CI_NAME,
	U_TASK_CMDB_CI_U_ID,
	Z_CLOSE_CODE,
	U_TASK_BUSINESS_SERVICE,
	U_TASK_U_CAUSATIVE_CI_NAME,
	U_TASK_STATE,
	Z_STATE,
	U_TASK_U_END_USER_ESCALATION,
	Z_REOPEN_COUNT,
	Z_SOURCE,
	Z_SOLVED_AT,
	Z_PRIORITY,
	U_TASK_REF_INCIDENT_U_MASTER_INCIDENT,
	U_TASK_REF_INCIDENT_PARENT_INCIDENT_NUMBER,
	Z_IS_MAJOR,
	U_AFFECTED_CIS,
	U_AFFECTED_DIVISIONS,
	U_TASK_LOCATION_NAME,
	U_TASK_LOCATION_U_CODE,
	U_TASK_LOCATION_U_NUMBER,
	U_TASK_LOCATION_U_TYPE,
	U_TASK_LOCATION_U_WAREHOUSE_NUMBER,
	U_TASK_U_CALLER_LOCATION_U_CODE,
	U_TASK_U_CALLER_U_UNIT_DEPARTMENT,
	U_TASK_U_CALLER_U_REGION_U_CODE,
	U_TASK_U_CALLER_DEPARTMENT_NAME,
	U_TASK_U_CALLER_COMPANY_NAME,
	U_TASK_U_CALLER_U_DIVISION_U_NAME,
	SYS_CREATED_ON,
	U_TASK_SYS_ID,
	U_TASK_U_WRONG_TICKET_ASSIGNMENT_COUNT,
	U_TASK_U_TICKET_DESCRIPTION_INCOMPLETE_COUNT,
	U_TASK_U_SYSTEM_OUTAGE,
	U_TASK_U_SYSTEM_OUTAGE_IN_MIN,
	U_TASK_U_COUNT_SHOULD_HAVE_BEEN_SOLVED_BY_EARLIER_SUPPORT_LEVEL,
	U_TASK_U_KNOWLEDGE_IS_MISSING,
	SLA_BUSINESS_DURATION_SECONDS,
	SLA_BUSINESS_PAUSE_DURATION_SECONDS,
	SLA_BUSINESS_PERCENTAGE,
	SLA_BUSINESS_TIME_LEFT_SECONDS,
	SLA_DURATION_SECONDS,
	SLA_HAS_BREACHED,
	SLA_PAUSE_DURATION_SECONDS,
	SLA_STAGE,
	SLA_CONTRACT_SLA_NAME,
	SLA_PLANNED_END_TIME
) as
select ticket.NUMBER as u_task_number, ticket.SYS_CLASS_NAME as u_task_sys_class_name, COALESCE(t_u_business_region.u_code, first_group.region_code) as u_task_u_region_u_code , COALESCE(t_u_division.u_name, first_group.divison_name) as u_task_u_division_u_name, ticket.u_division_business_region , t_u_division_business_region.u_label as u_task_u_division_business_region_u_label, resolved_group.name AS u_task_u_resolved_by_group_name , resolved_group.divison_name as u_task_u_resolved_by_group_u_division_u_name , resolved_group.region_code as u_task_u_resolved_by_group_u_region_u_code, resolved_group.manager_department as u_task_u_resolved_by_group_manager_department_name, first_group.name AS u_task_u_first_assignment_group_name  , first_group.divison_name as u_task_u_first_assignment_group_u_division_u_name  , first_group.region_code as u_task_u_first_assignment_group_u_region_u_code , first_group.manager_department as u_task_u_first_assignment_group_manager_department_name  , cmdb.name as u_task_cmdb_ci_name, cmdb.u_id as u_task_cmdb_ci_u_id , ticket_mapping_close_code.matching as Z_CLOSE_CODE, ticket.BUSINESS_SERVICE as u_task_business_service, causative_ci.name as u_task_U_CAUSATIVE_CI_NAME, ticket_mapping_state.matching as u_task_state, CASE WHEN u_task_state IN ('Analysis', 'Known Error', 'New', 'Open', 'Prepare Solution / Change', 'Wait for enduser', 'Wait for external', 'Wait for problem', 'Work in progress') THEN 'Open' ELSE 'Solved' END AS z_state,  ticket.U_END_USER_ESCALATION as U_TASK_U_END_USER_ESCALATION, Z_REOPEN_COUNT, ticket_mapping_source.matching as Z_SOURCE, COALESCE(Z_SOLVED_AT, DATE_TRUNC('day', CURRENT_TIMESTAMP()) + INTERVAL '8 hour' )::TIMESTAMP_NTZ AS Z_SOLVED_AT, ticket_mapping_priority.matching as Z_PRIORITY, ticket.u_master_incident as u_task_ref_incident_u_master_incident, parent_inc.number as u_task_ref_incident_parent_incident_number, Z_IS_MAJOR, U_AFFECTED_CIS, U_AFFECTED_DIVISIONS, location.name as u_task_location_name, location.u_code as u_task_location_u_code , location.u_number as u_task_location_u_number, location.u_type as u_task_location_u_type, location.u_warehouse_number as u_task_location_u_warehouse_number , caller.location_u_code as u_task_u_caller_location_u_code , caller.u_unit_department as u_task_u_caller_u_unit_department , caller.region_code as u_task_u_caller_u_region_u_code, caller.department_name as u_task_u_caller_department_name , caller.company_name as u_task_u_caller_company_name, caller.division_name as u_task_u_caller_u_division_u_name, ticket.sys_created_on, ticket.sys_id as u_task_sys_id, ticket.u_wrong_ticket_assignment_count as u_task_u_wrong_ticket_assignment_count, ticket.u_ticket_description_incomplete_count as u_task_u_ticket_description_incomplete_count, ticket.u_system_outage as u_task_u_system_outage, ticket.u_system_outage_in_min as u_task_u_system_outage_in_min, ticket.u_count_should_have_been_solved_by_earlier_support_level as u_task_u_count_should_have_been_solved_by_earlier_support_level, ticket.u_knowledge_is_missing as  u_task_u_knowledge_is_missing,
--TASK SLA Fields
SLA_BUSINESS_DURATION_SECONDS, SLA_BUSINESS_PAUSE_DURATION_SECONDS, BUSINESS_PERCENTAGE as SLA_BUSINESS_PERCENTAGE, SLA_BUSINESS_TIME_LEFT_SECONDS, SLA_DURATION_SECONDS, HAS_BREACHED as SLA_HAS_BREACHED, SLA_PAUSE_DURATION_SECONDS,  STAGE as SLA_STAGE,  SLA_CONTRACT_SLA_NAME, SLA_PLANNED_END_TIME
from data.v_tickets_min_2 as ticket
left join etl.t_cmn_location_2 as location_2 on ticket.location_2 = location.sys_id
left join etl.v_user_2 as caller on ticket.u_caller = caller.sys_id
left join etl.t_u_business_region_2 on ticket.u_region = t_u_business_region.sys_id
left join etl.t_cmdb_ci_2 as cmdb on ticket.cmdb_ci = cmdb.sys_id
left join etl.t_cmdb_ci_2 as causative_ci on ticket.u_causative_ci = causative_ci.sys_id
left join etl.t_incident_2 as parent_inc on ticket.parent_incident = parent_inc.sys_id
left join etl.v_user_group_2 as resolved_group on ticket.u_resolved_by_group = resolved_group.sys_id
left join etl.v_user_group_2 as first_group on ticket.u_first_assignment_group = first_group.sys_id
left join etl.t_u_division_2 on ticket.u_division = t_u_division.sys_id
left join etl.t_u_division_business_region_2 on ticket.u_division_business_region = t_u_division_business_region.sys_id
left join etl.ticket_mapping_state_2      on ticket.state = ticket_mapping_state.raw_data_state and ticket.sys_class_name = ticket_mapping_state.sys_class_name
left join etl.ticket_mapping_priority_2   on ticket.z_priority= ticket_mapping_priority.raw_data_priority and ticket.sys_class_name = ticket_mapping_priority.sys_class_name
left join etl.ticket_mapping_close_code_2 on ticket.u_close_code = ticket_mapping_close_code.raw_data_close_code
    and ticket.sys_class_name = ticket_mapping_close_code.sys_class_name
left join etl.ticket_mapping_source_2     on ticket.u_source = ticket_mapping_source.raw_data_source and ticket.sys_class_name = ticket_mapping_source.sys_class_name
left join data.v_task_resolution_sla_2 on ticket.sys_id = v_task_resolution_sla.task
WHERE NOT (U_TASK_STATE IN ('Closed', 'Closed Not Resolved', 'Closed Resolved', 'Completed', 'Resolved') AND Z_SOLVED_AT IS NULL )
;