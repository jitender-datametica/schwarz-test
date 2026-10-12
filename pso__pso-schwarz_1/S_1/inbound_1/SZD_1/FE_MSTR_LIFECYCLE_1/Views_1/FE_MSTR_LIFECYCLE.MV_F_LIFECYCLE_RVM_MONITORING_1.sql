CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_MONITORING_1 
AS
SELECT 
 core.t_fact_rvm_monitoring.rvm_sid
,core.t_fact_rvm_monitoring.cal_dt
,core.t_fact_rvm_monitoring.files_EXP_cnt
,core.t_fact_rvm_monitoring.files_miss_cnt
FROM 
core.t_fact_rvm_monitoring_1
;