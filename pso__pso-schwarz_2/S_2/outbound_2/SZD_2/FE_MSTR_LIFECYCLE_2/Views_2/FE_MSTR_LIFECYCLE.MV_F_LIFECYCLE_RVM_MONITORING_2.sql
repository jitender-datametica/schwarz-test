CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_monitoring_2 AS SELECT rvm_sid,
 cal_dt,
 files_exp_cnt,
 files_miss_cnt
FROM szd_core.t_fact_rvm_monitoring_2;