create or replace view PROCESS_MINING_PRODUCTION.EVAL.T_U_ASSIGNMENT_GROUP_HISTORY_DEDUP_L3_2(
	U_ASSIGNED_BY,
	U_ASSIGNMENT_REVOKED_BY,
	SYS_ID,
	SYS_UPDATED_ON,
	SEQNUM
) as
select *
from ( select *, row_number() over (partition by sys_id order by sys_updated_on desc) as seqnum
from PROCESS_MINING_PRODUCTION.ETL.T_U_ASSIGNMENT_GROUP_HISTORY_L3_2)
where seqnum = 1;