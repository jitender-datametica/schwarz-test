create or replace view PROCESS_MINING_PRODUCTION.EVAL.V_TICKET_SLA_DURATION_SOLUTIONS_2(
	U_TASK,
	NUMBER,
	STATE,
	COUNTRY_2,
	U_SYS_CLASS_NAME,
	ERSTE_RELEVANTE_GRUPPE,
	START_TIME,
	OPENED_AT,
	RESOLVED_AT,
	SYS_UPDATED_ON,
	BUSINESS_DURATION,
	DURATION_DAYS,
	DURATION_HOURS,
	DURATION_HOURS_TOTAL
) as
select u_task,inc.number, inc.state, t_cmn_location.country_2,  group_history.u_sys_class_name,  t_sys_user_group.name  as erste_relevante_gruppe,  sla.start_time , inc.opened_at, inc.resolved_at ,group_history.sys_updated_on, business_duration, datediff(day,to_timestamp_ntz('1970-01-01 00:00:00'), to_timestamp_ntz(business_duration) ) as duration_days, mod(datediff(hour,to_timestamp_ntz('1970-01-01 00:00:00'), to_timestamp_ntz(business_duration) ),24) as duration_hours, datediff(hour,to_timestamp_ntz('1970-01-01 00:00:00'), to_timestamp_ntz(business_duration) ) as duration_hours_total from (
select * from etl.t_u_assignment_group_history_2 where u_sys_class_name = 'incident' and u_assignment_group in ('7c5f1533db883348ddce449e3b961967', '63676e16dbb501501ce29197f496191a', '5eba36f1db22e090ed72a6b605961947', '9bdf6e0c1b25d0501ba042eacd4bcb88', '7b5e9e9c1b9815d0d59e986c9b4bcb9b', 'b44f55ffdb483348ddce449e3b961944', 'f29758e01ba0b8105f17a6c8, bb4bcb17', '79dfd1b7db00770070da6d340596198b', 'e2ea303fdb2cd950799cfad3f39619be', '4c7a72b1db22e090ed72a6b605961925', '0a1ea809db7ed4dc50930a9bd3961948', '06f8a54adb4114d408cfba03f39619cd', '84aa7eb1db22e090ed72a6b60596191b', '845f5133db883348ddce449e3b961987', '7a62fec41b219050af067553dd4bcbad', 'fffa06f6dbe6185c50930a9bd3961940', '62a5a2a9974165905959fc000153afc1', '352a3a31db22e090ed72a6b605961920', 'd8199ae61b09805c8e8655be6e4bcbe4', 'cfdbeead1bf14c58ced57448cd4bcb3a', '89934d5d6f0b7600ec1748f42e3ee41c', '42970f07978039d4dc2330200153af3a', '269f6c63db8c3b08ddce449e3b96194f', '6ff28cf1db34af8cb4062e65ca961942', 'f2df15b7db00770070da6d34059619f1', 'd0df11b7db00770070da6d34059619e2', 'e68ab6b1db22e090ed72a6b60596196e')) as group_history
--qualify row_number() over (partition by u_task order by sys_updated_on desc) =1
left join etl.t_sys_user_group_2 on group_history.u_assignment_group = t_sys_user_group.sys_id
left join etl.t_incident_2 as inc on group_history.u_task = inc.sys_id
left join etl.t_task_sla_2 as sla on sla.task = group_history.u_task
left join etl.t_contract_sla_2 as contract on sla.sla = contract.sys_id
left join etl.t_cmn_location_2 on inc.location_2 = t_cmn_location.sys_id
where sla.start_time > '2023-05-01 00:00:00'
and contract.name like '%resolution'
qualify row_number() over (partition by u_task order by group_history.sys_updated_on desc) =1;