create or replace view PROCESS_MINING_PRODUCTION.ETL.V_USER_2(
	SYS_ID,
	REGION_CODE,
	U_UNIT_DEPARTMENT,
	LOCATION_U_CODE,
	DEPARTMENT_NAME,
	COMPANY_NAME,
	DIVISION_NAME
) as
select t_sys_user.sys_id, region.u_code as region_code , u_unit_department, location.u_code as location_u_code, department.name as department_name , null as company_name, division.u_name as division_name from etl.t_sys_user_2
left join etl.t_u_business_region_2 as region_2 on t_sys_user.u_region = region.sys_id
left join etl.t_cmn_location_2 as location_2 on t_sys_user.location_2 = location.sys_id
left join etl.t_cmn_department_2 as department on t_sys_user.department=  department.sys_id
left join etl.t_u_division_2 as division on t_sys_user.u_division = division.sys_id;