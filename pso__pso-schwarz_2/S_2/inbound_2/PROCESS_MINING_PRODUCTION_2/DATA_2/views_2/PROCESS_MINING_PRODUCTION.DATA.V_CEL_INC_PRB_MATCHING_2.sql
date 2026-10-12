create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_INC_PRB_MATCHING_2(
	INCIDENT_NUMBER,
	REGION_U_CODE,
	DIVISION_U_NAME,
	PROBLEM_NUMBER
) as
 select
ticket.number as incident_number, COALESCE(t_u_business_region.u_code, first_group.region_code) as region_u_code , COALESCE(t_u_division.u_name, first_group.divison_name) as division_u_name,  t_problem.number as problem_number from etl.t_incident_2 as ticket
left join etl.v_user_group_2 as assigned_group on ticket.assignment_group = assigned_group.sys_id
left join etl.ticket_mapping_source_2     on ticket.u_source = ticket_mapping_source.raw_data_source and 'incident' = ticket_mapping_source.sys_class_name
left join etl.ticket_mapping_close_code_2 on ticket.u_close_code = ticket_mapping_close_code.raw_data_close_code and 'incident' = ticket_mapping_close_code.sys_class_name
left join etl.ticket_mapping_state_2      on ticket.state = ticket_mapping_state.raw_data_state and ticket.sys_class_name = ticket_mapping_state.sys_class_name
left join etl.t_cmdb_ci_2 as cmdb on ticket.cmdb_ci = cmdb.sys_id
left join etl.t_cmn_location_2 as location_2 on ticket.location_2 = location.sys_id
left join etl.t_u_division_2 on ticket.u_division = t_u_division.sys_id
left join etl.t_u_division_business_region_2 on ticket.u_division_business_region = t_u_division_business_region.sys_id
left join etl.t_u_business_region_2 on ticket.u_region = t_u_business_region.sys_id
left join etl.v_user_group_2 as first_group on ticket.u_first_assignment_group = first_group.sys_id
left join etl.t_problem_2 on ticket.problem_id = t_problem.sys_id
AND region_u_code = 'GB' AND division_u_name = 'Lidl' AND first_group.name ='ldl-gb-it-ext-topdesk';