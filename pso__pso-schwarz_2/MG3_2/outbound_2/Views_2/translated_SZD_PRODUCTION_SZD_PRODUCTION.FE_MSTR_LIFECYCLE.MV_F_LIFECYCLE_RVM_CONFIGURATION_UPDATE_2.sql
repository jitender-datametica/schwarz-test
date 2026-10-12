CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_configuration_update_2 (rvm_sid, update_dt,
rec_cnt, rvm_config_source_cd, update_status_fg, cal_dt) AS SELECT rvm_sid,
 update_dt,
 rec_cnt,
 rvm_config_source_cd,
 update_status_fg,
 cal_dt
FROM szd_production_core.t_fact_rvm_configuration_update_2;