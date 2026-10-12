create or replace view IDQ_PRODUCTION.DQ_REPORTS.V_DQ_LDL_EKS_CALCULATION_TIME_RULES_2(
	REF_COUNTRY_ID,
	CALCULATION_TIME
) as
select
    ch.ref_country_id REF_COUNTRY_ID,
    max(eh.END_TIME) CALCULATION_TIME
from dwh.check_history_2 ch
cross join EKS_CALCULATION.EXECUTION_HISTORY_2 eh
where ref_source_system_type_id = 1 and check_history_is_current = 1
group by ch.ref_country_id;