create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_INCIDENT_1WEEK_GB(
	NUMBER,
	SHORT_DESCRIPTION,
	DESCRIPTION,
	CLOSE_NOTES,
	CLOSE_CODE,
	ASSIGNMENT_GROUP,
	ASSIGNMENT_GROUP_DISPLAY_VALUE,
	SOURCESYSTEM,
	ASSIGNED_TO_DISPLAY_VALUE,
	OPENED_BY_DISPLAY_VALUE,
	CONTACT_TYPE_DISPLAY_VALUE,
	CATEGORY,
	SUBCATEGORY,
	CMDB_CI_DISPLAY_VALUE,
	BUSINESS_SERVICE_DISPLAY_VALUE,
	LOCATION_DISPLAY_VALUE,
	PRIORITY_DISPLAY_VALUE,
	IMPACT_DISPLAY_VALUE,
	URGENCY_DISPLAY_VALUE,
	REGION_U_CODE,
	DIVISION_U_NAME,
	REOPEN_COUNT,
	STATE_DISPLAY_VALUE,
	OPENED_AT,
	CLOSED_AT,
	SYS_ID,
	SYS_UPDATED_ON,
	PROBLEM_NUMBER
) as select
ticket.number, ticket.short_description, ticket.description, ticket.u_solution as close_notes, ticket_mapping_close_code.matching as close_code,   ticket.assignment_group, assigned_group.name as assignment_group_display_value, 'IT4YOU' as sourceSystem, NULL as assigned_to_display_value, NULL as opened_by_display_value, ticket_mapping_source.matching as contact_type_display_value, NULL as category, NULL as subcategory, cmdb.name as cmdb_ci_display_value, NULL as business_service_display_value, location.u_code as location_display_value,
ticket.priority AS priority_display_value,
NULL as impact_display_value,
NULL AS urgency_display_value,
COALESCE(t_u_business_region.u_code, first_group.region_code) as region_u_code , COALESCE(t_u_division.u_name, first_group.divison_name) as division_u_name,
 reopen_count, ticket_mapping_state.matching as state_display_value, ticket.opened_at, ticket.closed_at, ticket.sys_id, ticket.sys_updated_on, t_problem.number as problem_number from etl.t_incident as ticket
left join etl.v_user_group as assigned_group on ticket.assignment_group = assigned_group.sys_id
left join etl.ticket_mapping_source     on ticket.u_source = ticket_mapping_source.raw_data_source and 'incident' = ticket_mapping_source.sys_class_name
left join etl.ticket_mapping_close_code on ticket.u_close_code = ticket_mapping_close_code.raw_data_close_code and 'incident' = ticket_mapping_close_code.sys_class_name
left join etl.ticket_mapping_state      on ticket.state = ticket_mapping_state.raw_data_state and ticket.sys_class_name = ticket_mapping_state.sys_class_name
left join etl.t_cmdb_ci as cmdb on ticket.cmdb_ci = cmdb.sys_id
left join etl.t_cmn_location as location on ticket.location = location.sys_id
left join etl.t_u_division on ticket.u_division = t_u_division.sys_id
left join etl.t_u_division_business_region on ticket.u_division_business_region = t_u_division_business_region.sys_id
left join etl.t_u_business_region on ticket.u_region = t_u_business_region.sys_id
left join etl.v_user_group as first_group on ticket.u_first_assignment_group = first_group.sys_id
left join etl.t_problem on ticket.problem_id = t_problem.sys_id
where ticket.sys_created_on >= '2025-09-01' AND  ticket.sys_created_on <= '2025-09-07'  AND region_u_code = 'GB' AND division_u_name = 'Lidl'
AND first_group.name ='ldl-gb-it-ext-topdesk' ;