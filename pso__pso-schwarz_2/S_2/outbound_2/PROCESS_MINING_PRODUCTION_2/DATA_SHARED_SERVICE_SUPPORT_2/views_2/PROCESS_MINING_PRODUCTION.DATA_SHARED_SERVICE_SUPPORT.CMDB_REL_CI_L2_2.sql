CREATE OR REPLACE VIEW process_mining_production_data_shared_service_support.cmdb_rel_ci_l2_2 (child, child_name, parent,
parent_name, sys_created_on, u_global_id, u_source, sys_id, sys_updated_on) AS SELECT t_cmdb_rel_ci.child,
 CMDB_CI_CHILD.name AS child_name,
 t_cmdb_rel_ci.parent,
 CMDB_CI_PARENT.name AS parent_name,
 t_cmdb_rel_ci.sys_created_on,
 t_cmdb_rel_ci.u_global_id,
 t_cmdb_rel_ci.u_source,
 t_cmdb_rel_ci.sys_id,
 t_cmdb_rel_ci.sys_updated_on
FROM process_mining_production_etl.t_cmdb_rel_ci_2
 LEFT JOIN process_mining_production_etl.t_cmdb_ci_2 AS CMDB_CI_CHILD ON t_cmdb_rel_ci.child = CMDB_CI_CHILD.sys_id
 LEFT JOIN process_mining_production_etl.t_cmdb_ci_2 AS CMDB_CI_PARENT ON t_cmdb_rel_ci.parent = CMDB_CI_PARENT.sys_id;