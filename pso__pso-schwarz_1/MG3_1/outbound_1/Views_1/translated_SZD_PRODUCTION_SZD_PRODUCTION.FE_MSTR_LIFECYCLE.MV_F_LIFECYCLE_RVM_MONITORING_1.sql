CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_monitoring_1 (rvm_sid, cal_dt, files_exp_cnt,
files_miss_cnt) AS SELECT rvm_sid,
 cal_dt,
 files_exp_cnt,
 files_miss_cnt
FROM szd_production_core.t_fact_rvm_monitoring_1;