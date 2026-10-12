create or replace view PROCESS_MINING_PRODUCTION.DATA.V_EVENTS_STATES_TIMES_AGGREGATED_PER_TICKET(
	U_TASK_NUMBER,
	U_TASK_SYS_CLASS_NAME,
	Z_SOLVED_AT,
	Z_CLOSE_CODE,
	U_TASK_U_REGION_U_CODE,
	U_ASSIGNMENT_GROUP_NAME,
	TIME_NEW,
	TIME_OPEN,
	TIME_WORK_IN_PROGRESS,
	TIME_WAITING_FOR_ENDUSER,
	TIME_WAITING_FOR_EXTERNAL,
	TIME_WAITING_FOR_PROBLEM,
	TIME_TOTAL
) as
select v_tickets_last2years.U_TASK_NUMBER, u_task_sys_class_name, z_solved_at, z_close_code, U_TASK_U_REGION_U_CODE, U_ASSIGNMENT_GROUP_NAME, TIME_NEW, TIME_OPEN,TIME_WORK_IN_PROGRESS, TIME_WAITING_FOR_ENDUSER, TIME_WAITING_FOR_EXTERNAL, TIME_WAITING_FOR_PROBLEM, time_total from v_events_states_times_aggregated_per_ticket_helper
left join data.v_tickets_last2years on v_tickets_last2years.u_task_number = v_events_states_times_aggregated_per_ticket_helper.u_task_number
where u_task_sys_class_name != 'problem';