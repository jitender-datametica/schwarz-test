create or replace view PROCESS_MINING_PRODUCTION.DATA_SHARED_SERVICE_SUPPORT.CMDB_REL_CI_L2_2(
	CHILD,
	CHILD_NAME,
	PARENT,
	PARENT_NAME,
	SYS_CREATED_ON,
	U_GLOBAL_ID,
	U_SOURCE,
	SYS_ID,
	SYS_UPDATED_ON
) as
SELECT CHILD, CMDB_CI_CHILD.name AS CHILD_NAME, PARENT, CMDB_CI_PARENT.name AS PARENT_NAME, t_cmdb_rel_ci.SYS_CREATED_ON, t_cmdb_rel_ci.U_GLOBAL_ID, t_cmdb_rel_ci.U_SOURCE, t_cmdb_rel_ci.SYS_ID, t_cmdb_rel_ci.SYS_UPDATED_ON
from etl.t_cmdb_rel_ci_2
left join etl.t_cmdb_ci_2 AS CMDB_CI_CHILD on t_cmdb_rel_ci.child = CMDB_CI_CHILD.sys_id
left join etl.t_cmdb_ci_2 AS CMDB_CI_PARENT on t_cmdb_rel_ci.parent = CMDB_CI_PARENT.sys_id;