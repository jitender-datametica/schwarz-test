create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_RVM_DATA_NOT_TRANSMITTED_1(
	RVM_SID,
	RVM_PROCESSING_DT,
	DIFF_IN_DAYS_CNT
) as SELECT
 core.t_fact_rvm_delivery_status.rvm_sid
,core.t_fact_rvm_delivery_status.rvm_processing_dt
,core.t_fact_rvm_delivery_status.diff_in_days_cnt
FROM
core.t_fact_rvm_delivery_status_1
;