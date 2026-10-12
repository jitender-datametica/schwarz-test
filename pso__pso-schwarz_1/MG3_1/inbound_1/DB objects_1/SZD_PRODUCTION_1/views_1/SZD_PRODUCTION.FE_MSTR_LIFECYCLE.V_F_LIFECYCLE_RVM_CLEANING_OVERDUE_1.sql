create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_RVM_CLEANING_OVERDUE_1(
	RVM_SID,
	LAST_GREEN_CLEANING_DT,
	DIFF_DAYS
) as
select * from (
select
rvm_sid
,max(END_OF_CLEANING_DT) as last_green_cleaning_dt
,datediff(days, last_green_cleaning_dt, current_date -1) as diff_days
from core.t_Fact_rvm_cleaning_1
where 1=1
and CLEANING_DUR_SEC_CNT between 130 and 540
and CLEANING_STATUS_CD = 'com'



group by rvm_sid
)
where DIFF_DAYS > 2
order by LAST_GREEN_CLEANING_DT desc
;