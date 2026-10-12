CREATE OR REPLACE VIEW process_mining_production_etl.v_user_group_1 (sys_id, name, divison_code, divison_name, region_code
, manager_department) AS SELECT t_sys_user_group.sys_id,
 t_sys_user_group.name,
 DIVISON.u_code AS divison_code,
 DIVISON.u_name AS divison_name,
 REGION.u_code AS region_code,
 MANAGER_DEPARTMENT0.name AS manager_department
FROM process_mining_production_etl.t_sys_user_group_1
 LEFT JOIN process_mining_production_etl.t_u_division_1 AS DIVISON ON t_sys_user_group.u_division = DIVISON.sys_id
 LEFT JOIN process_mining_production_etl.t_u_business_region_1 AS REGION_1 ON t_sys_user_group.u_region = REGION.sys_id
 LEFT JOIN process_mining_production_etl.t_sys_user_1 AS USER_MANAGER ON t_sys_user_group.manager = USER_MANAGER.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department_1 AS MANAGER_DEPARTMENT0 ON USER_MANAGER.department =
  MANAGER_DEPARTMENT0.sys_id;