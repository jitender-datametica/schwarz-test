create or replace view PROCESS_MINING_PRODUCTION.ETL.V_USER(
	SYS_ID,
	REGION_CODE,
	U_UNIT_DEPARTMENT,
	LOCATION_U_CODE,
	DEPARTMENT_NAME,
	COMPANY_NAME,
	DIVISION_NAME
) as
select t_sys_user.sys_id, region.u_code as region_code , u_unit_department, location.u_code as location_u_code, department.name as department_name , null as company_name, division.u_name as division_name from etl.t_sys_user
left join etl.t_u_business_region as region on t_sys_user.u_region = region.sys_id
left join etl.t_cmn_location as location on t_sys_user.location = location.sys_id
left join etl.t_cmn_department as department on t_sys_user.department=  department.sys_id
left join etl.t_u_division as division on t_sys_user.u_division = division.sys_id;