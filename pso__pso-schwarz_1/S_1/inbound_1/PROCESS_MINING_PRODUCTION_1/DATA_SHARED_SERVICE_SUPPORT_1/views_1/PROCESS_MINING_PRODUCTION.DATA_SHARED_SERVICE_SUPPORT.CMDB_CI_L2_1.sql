create or replace view PROCESS_MINING_PRODUCTION.DATA_SHARED_SERVICE_SUPPORT.CMDB_CI_L2_1(
	SYS_ID,
	U_GLOBAL_ID,
	CMDB_CI_NAME,
	SYS_CLASS_NAME,
	U_CI_TYPE,
	U_STATE,
	OWNED_BY_DEPARTMENT_NAME,
	DEPARTMENT_ORG_LEVEL_1,
	DEPARTMENT_ORG_LEVEL_2,
	DEPARTMENT_ORG_LEVEL_3,
	DEPARTMENT_ORG_LEVEL_4
) as
select T_CMDB_CI.sys_id, u_global_id, T_CMDB_CI.name as CMDB_CI_NAME, T_CMDB_CI.sys_class_name, u_ci_type,T_CMDB_CI.u_state, department.name as OWNED_BY_DEPARTMENT_NAME, u_obs_l1.name as DEPARTMENT_ORG_LEVEL_1, u_obs_l2.name as DEPARTMENT_ORG_LEVEL_2, u_obs_l3.name as DEPARTMENT_ORG_LEVEL_3, u_obs_l4.name as DEPARTMENT_ORG_LEVEL_4   from etl.t_cmdb_ci_1
left join etl.t_sys_user_1 as owner on owner.sys_id = t_cmdb_ci.owned_by
left join etl.t_cmn_department_1 as department on department.sys_id = owner.u_obs_department
left join etl.t_cmn_department_1 as u_obs_l1 on department.u_obs_level_1 = u_obs_l1.sys_id
left join etl.t_cmn_department_1 as u_obs_l2 on department.u_obs_level_2 = u_obs_l2.sys_id
left join etl.t_cmn_department_1 as u_obs_l3 on department.u_obs_level_3 = u_obs_l3.sys_id
left join etl.t_cmn_department_1 as u_obs_l4 on department.u_obs_level_4 = u_obs_l4.sys_id
where T_CMDB_CI.sys_class_name IN ('cmdb_ci_service', 'cmdb_ci_business_app') OR u_it_portfolio_item IN ('IT-Solution','Business Solution')
OR ( install_status ='1' AND u_creation_method = 'manual_ci' );