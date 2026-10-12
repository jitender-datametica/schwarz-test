create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_SYS_USER_GROUP(
	SYS_ID,
	NAME,
	SOURCESYSTEM,
	ACTIVE,
	TYPE_DISPLAY_VALUE,
	PARENT_DISPLAY_VALUE,
	MANAGER_DISPLAY_VALUE,
	DESCRIPTION
) as select t_sys_user_group.sys_id, t_sys_user_group.name, 'IT4YOU' as sourceSystem, t_sys_user_group.active, t_sys_user_group.type as type_display_value, parent_group.name as parent_display_value, NULL AS manager_display_value, t_sys_user_group.description
from etl.t_sys_user_group
left join etl.t_sys_user_group as parent_group on t_sys_user_group.parent = parent_group.sys_id;