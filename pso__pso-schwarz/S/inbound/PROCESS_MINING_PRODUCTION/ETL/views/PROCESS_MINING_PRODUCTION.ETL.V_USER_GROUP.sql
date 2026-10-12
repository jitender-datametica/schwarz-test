create or replace view PROCESS_MINING_PRODUCTION.ETL.V_USER_GROUP(
	SYS_ID,
	NAME,
	DIVISON_CODE,
	DIVISON_NAME,
	REGION_CODE,
	MANAGER_DEPARTMENT
) as
select t_sys_user_group.sys_id, t_sys_user_group.name, divison.u_code as divison_code, divison.u_name as divison_name, region.u_code as region_code, manager_department.name as manager_department from etl.t_sys_user_group
left join etl.t_u_division as divison on t_sys_user_group.u_division = divison.sys_id
left join etl.t_u_business_region as region on t_sys_user_group.u_region = region.sys_id
left join etl.t_sys_user as user_manager on t_sys_user_group.manager = user_manager.sys_id
left join etl.t_cmn_department as manager_department on user_manager.department = manager_department.sys_id;