CREATE OR REPLACE VIEW process_mining_production_etl.v_user (sys_id, region_code, u_unit_department, location_u_code,
department_name, company_name, division_name) AS SELECT t_sys_user.sys_id,
 REGION.u_code AS region_code,
 t_sys_user.u_unit_department,
 LOCATION.u_code AS location_u_code,
 DEPARTMENT.name AS department_name,
 NULL AS company_name,
 DIVISION.u_name AS division_name
FROM process_mining_production_etl.t_sys_user
 LEFT JOIN process_mining_production_etl.t_u_business_region AS REGION ON t_sys_user.u_region = REGION.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_location AS LOCATION ON t_sys_user.location = LOCATION.sys_id
 LEFT JOIN process_mining_production_etl.t_cmn_department AS DEPARTMENT ON t_sys_user.department = DEPARTMENT.sys_id
 LEFT JOIN process_mining_production_etl.t_u_division AS DIVISION ON t_sys_user.u_division = DIVISION.sys_id;