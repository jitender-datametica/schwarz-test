create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_CONTRACT_SLA_1(
	SYS_ID,
	TARGET_DISPLAY_VALUE,
	SYS_NAME
) as
select sys_id, 'Resolution' as target_display_value, sys_name from etl.t_contract_sla_1
 where T_CONTRACT_SLA.NAME like '%resolution';