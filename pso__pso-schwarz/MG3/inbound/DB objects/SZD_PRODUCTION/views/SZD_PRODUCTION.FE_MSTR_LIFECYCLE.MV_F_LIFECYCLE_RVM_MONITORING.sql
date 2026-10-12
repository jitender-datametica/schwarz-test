create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_MONITORING(
	RVM_SID,
	CAL_DT,
	FILES_EXP_CNT,
	FILES_MISS_CNT
) as
SELECT 
 core.t_fact_rvm_monitoring.rvm_sid
,core.t_fact_rvm_monitoring.cal_dt
,core.t_fact_rvm_monitoring.files_EXP_cnt
,core.t_fact_rvm_monitoring.files_miss_cnt
FROM 
core.t_fact_rvm_monitoring
;