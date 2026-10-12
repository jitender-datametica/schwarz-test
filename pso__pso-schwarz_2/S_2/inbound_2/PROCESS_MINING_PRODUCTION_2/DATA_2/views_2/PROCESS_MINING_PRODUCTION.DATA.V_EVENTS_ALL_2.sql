create or replace view PROCESS_MINING_PRODUCTION.DATA.V_EVENTS_ALL_2(
	U_TASK_NUMBER,
	START_TIMESTAMP,
	EVENT,
	END_TIMESTAMP,
	U_ORDER,
	EVENT_LEVEL,
	U_ASSIGNMENT_GROUP_NAME
) as
(select u_task_number, start_timestamp, event, end_timestamp, 9999 as U_ORDER, event_level, u_assignment_group_name  from data.v_events_states_2
UNION
select u_task_number, u_assigned_at as start_timestamp, u_assignment_group_name as event, u_assignment_revoked_at as end_timestamp, u_order, 'assignment' as event_level, u_assignment_group_name from data.v_events_assignments_2);