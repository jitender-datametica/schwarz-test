create or replace view UGS_ARIS_PRODUCTION.FE_MSTR_ARIS.V_FACT_WORLD(
	DWH_TENANT_CD,
	COUNTRY_ORG_SID,
	COUNTRY_ORG_NAME,
	NUMBER_PROCESSES_INT,
	NUMBER_PROCESSES,
	NUMBER_PROCESSES_CUR,
	NUMBER_PROCESSES_UPDT,
	NUMBER_PROCESSES_ABW,
	NUMBER_PROCESSES_UNV,
	NUMBER_PROCESSES_ERG,
	ROLLOUT_DUR_DAY_SUM,
	ROLLOUT_DUR_DAY_CNT
) as SELECT
DWH_TENANT_CD,
COUNTRY_ORG_SID,
case when COUNTRY_ORG_NAME = 'Lidl Asia' then 'Hong Kong' else COUNTRY_ORG_NAME end as COUNTRY_ORG_NAME,
COUNT(Case when COUNTRY_ORG_NR = 'INT' and DWH_SRC_FILE_NAME = 'Lidl-Prozesse lesen MSTR'  then 1 end) as NUMBER_PROCESSES_INT,
COUNT(Case when COUNTRY_ORG_NR IS NOT NULL  then 1 end)    NUMBER_PROCESSES,
count(case when PROCESS_UPD_STATUS_CD = 'CUR' then 1 end)  NUMBER_PROCESSES_CUR,
count(case when PROCESS_UPD_STATUS_CD = 'UPDT' then 1 end) NUMBER_PROCESSES_UPDT,
count(case when process_change_lvl_cd = 'Abw' then 1 end)  NUMBER_PROCESSES_ABW,
count(case when process_change_lvl_cd = 'Unv' then 1 end)  NUMBER_PROCESSES_UNV,
count(case when process_change_lvl_cd = 'Erg' then 1 end)  NUMBER_PROCESSES_ERG,
  sum(case when PROCESS_ROLLOUT_STATUS_CD = 0 and (APPROVAL_DT between add_months(last_day(current_date)+1,-2) and add_months(last_day(current_date),-1)) then (ROLLOUT_DUR_DAY_CNT) else 0 end) as ROLLOUT_DUR_DAY_SUM,
count(case when PROCESS_ROLLOUT_STATUS_CD = 0 and (APPROVAL_DT between add_months(last_day(current_date)+1,-2) and add_months(last_day(current_date),-1)) then (ROLLOUT_DUR_DAY_CNT) end) as ROLLOUT_DUR_DAY_CNT

FROM FE_MSTR_ARIS.V_DIM_PROCESS
WHERE DWH_TENANT_CD = 'L' and COUNTRY_SPECIFIC_PROCESS_FG = 'False' and process_sid > 0
group by DWH_TENANT_CD, COUNTRY_ORG_SID, COUNTRY_ORG_NAME;