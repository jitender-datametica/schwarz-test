CREATE OR REPLACE VIEW process_mining_production_data_shared_service_support.cmdb_ci_l2 (sys_id, u_global_id,
cmdb_ci_name, sys_class_name, u_ci_type, u_state, owned_by_department_name, department_org_level_1,
department_org_level_2, department_org_level_3, department_org_level_4) AS SELECT t_cmdb_ci.sys_id,
 t_cmdb_ci.u_global_id,
 t_cmdb_ci.name AS cmdb_ci_name,
 t_cmdb_ci.sys_class_name,
 t_cmdb_ci.u_ci_type,
 t_cmdb_ci.u_state,
 DEPARTMENT.name AS owned_by_department_name,
 U_OBS_L1.name AS department_org_level_1,
 U_OBS_L2.name AS department_org_level_2,
 U_OBS_L3.name AS department_org_level_3,
 U_OBS_L4.name AS department_org_level_4
FROM process_mining_production_etl.t_cmdb_ci
 LEFT JOIN process_mining_production_etl.t_sys_user AS OWNER ON t_cmdb_ci.owned_by = OWNER.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department AS DEPARTMENT ON OWNER.u_obs_department = DEPARTMENT.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department AS U_OBS_L1 ON DEPARTMENT.u_obs_level_1 = U_OBS_L1.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department AS U_OBS_L2 ON DEPARTMENT.u_obs_level_2 = U_OBS_L2.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department AS U_OBS_L3 ON DEPARTMENT.u_obs_level_3 = U_OBS_L3.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department AS U_OBS_L4 ON DEPARTMENT.u_obs_level_4 = U_OBS_L4.sys_id
WHERE t_cmdb_ci.sys_class_name IN ('cmdb_ci_service', 'cmdb_ci_business_app')
 OR t_cmdb_ci.u_it_portfolio_item IN ('IT-Solution', 'Business Solution')
 OR t_cmdb_ci.install_status = 1 AND t_cmdb_ci.u_creation_method = 'manual_ci';