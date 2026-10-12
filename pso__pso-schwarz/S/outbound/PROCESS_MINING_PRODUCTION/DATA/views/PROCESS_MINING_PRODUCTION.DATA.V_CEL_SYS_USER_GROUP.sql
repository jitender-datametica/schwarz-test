CREATE OR REPLACE VIEW process_mining_production_data.v_cel_sys_user_group (sys_id, name, sourcesystem, active,
type_display_value, parent_display_value, manager_display_value, description) AS SELECT t_sys_user_group.sys_id,
 t_sys_user_group.name,
 'IT4YOU' AS sourcesystem,
 t_sys_user_group.active,
 t_sys_user_group.type AS type_display_value,
 PARENT_GROUP.name AS parent_display_value,
 NULL AS manager_display_value,
 t_sys_user_group.description
FROM process_mining_production_etl.t_sys_user_group
 LEFT JOIN process_mining_production_etl.t_sys_user_group AS PARENT_GROUP ON t_sys_user_group.parent = PARENT_GROUP.sys_id;