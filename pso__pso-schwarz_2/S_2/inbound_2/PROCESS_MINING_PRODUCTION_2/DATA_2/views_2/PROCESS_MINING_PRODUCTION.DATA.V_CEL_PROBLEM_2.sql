create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_PROBLEM_2(
	SYS_ID,
	NUMBER,
	DESCRIPTION,
	SHORT_DESCRIPTION,
	SYS_CREATED_ON,
	PRIORITY,
	U_CLOSE_CODE,
	RELATED_INCIDENTS
) as
select sys_id, t_problem.number, t_problem.description, t_problem.short_description, sys_created_on, priority, u_close_code, related_incidents from etl.t_problem_2
where  (t_problem.u_division_business_region LIKE '%16444461db06f200a880fdabbf9619bb%' OR u_division_business_region LIKE '%f766a8c0db0a3200a880fdabbf9619a5%') AND sys_created_on >= '2024-01-01';