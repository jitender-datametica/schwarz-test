create or replace view PROCESS_MINING_PRODUCTION.DATA.V_EVENTS_ASSIGNMENTS_2(
	U_TASK_NUMBER,
	U_ORDER,
	U_ASSIGNED_AT,
	U_FINAL_ASSIGNMENT,
	U_ASSIGNMENT_GROUP_NAME,
	LAST_ASSIGNMENT_FLAG,
	U_ASSIGNMENT_REVOKED_AT
) as
select tickets.number as u_task_number, u_order, u_assigned_at,
u_final_assignment, etl.t_sys_user_group.name as U_ASSIGNMENT_GROUP_NAME,
CASE WHEN row_number() OVER (PARTITION BY u_task ORDER by u_order desc) = 1 THEN '1' ELSE '0' END as last_assignment_flag,
CASE WHEN last_assignment_flag =1 THEN z_solved_at ELSE u_assignment_revoked_at END as u_assignment_revoked_at
FROM ETL.T_U_ASSIGNMENT_GROUP_HISTORY_2
left join etl.t_sys_user_group_2 on u_assignment_group = t_sys_user_group.sys_id
inner join data.v_tickets_min_Last2Years_2 as tickets on t_u_assignment_group_history.u_task = tickets.sys_id
where t_u_assignment_group_history.u_sys_class_name IN ('incident', 'u_request', 'problem') and u_order != '0'
qualify NOT (last_assignment_flag ='1' AND IFF(Z_SOLVED_AT IS NULL, FALSE, (Z_SOLVED_AT <= t_u_assignment_group_history.sys_updated_on) )) AND NOT (last_assignment_flag ='0' AND u_final_assignment = 'TRUE');